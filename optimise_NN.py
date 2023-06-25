import sqlite3
from datetime import datetime
from random import random
from joblib import dump, load
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from keras import optimizers, regularizers
from keras.layers import Dense, Dropout, Normalization
from keras.models import Sequential, load_model, save_model
from sklearn import preprocessing
from alive_progress import alive_bar

from scripts.stats import get_all_matches_for_player, get_match_stats
import logging
from tqdm import tqdm

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

labels = [
    "Hard",
    "Clay",
    "Grass",
    "Carpet",
    "Future",
    "Master",
    "ATP",
    "Challenger",
    "Grand Slam",
    "Q1",
    "Q2",
    "Q3",
    "Q4",
    "R128",
    "R64",
    "R32",
    "R16",
    "QF",
    "SF",
    "F",
    "RR",
    "A_previous_elo",
    "B_previous_elo",
    "A_peak_elo",
    "B_peak_elo",
    "A_h2h",
    "B_h2h",
]

# Adding labels for the performance stats and win-loss stats for both players
for i in range(16):
    labels.append("A_performance_stat_" + str(i))
for i in range(16):
    labels.append("B_performance_stat_" + str(i))
for i in range(32):
    labels.append("A_win_loss_stat_" + str(i))
for i in range(32):
    labels.append("B_win_loss_stat_" + str(i))

swapped_labels = []
for label in labels:
    if "A_" in label:
        swapped_labels.append(label.replace("A_", "B_"))
    elif "B_" in label:
        swapped_labels.append(label.replace("B_", "A_"))
    else:
        swapped_labels.append(label)


class MatchData:
    def __init__(self, conn, recalculate_stats):
        self.conn = conn
        self.recalculate_stats = recalculate_stats
        self.player_match_dict = {}
        self.X = np.array([[None]])
        self.Y = np.array([[None]])

        if self.recalculate_stats:
            self.matches = self.load_data()
            self.process_data()
        else:
            self.matches = self.load_from_csv("data/training_data.csv")

    def load_data(self):
        logger.debug("Starting load_data")
        query = "SELECT * FROM tennis_matches WHERE match_id >= '2010' AND tourney_level != 'F' AND tourney_level != 'C' ORDER BY match_id ASC"
        matches_df = pd.read_sql_query(query, self.conn)
        logger.debug("Finished load_data")
        return matches_df.to_dict("records")

    def load_from_csv(self, file_path):
        matches = pd.read_csv(file_path).to_dict("records")
        for match in tqdm(matches, desc="Loading matches", smoothing=0.8):
            data_list = [match[label] for label in labels]
            result = match["result"]
            self.append_data(data_list, result)
        return matches

    def process_data(self):
        logger.debug("Starting process_data")
        excluded_levels = ["F", "C"]
        with alive_bar(len(self.matches), title="Processing matches") as bar:
            for m in self.matches:
                self.process_match(m, excluded_levels)
                bar()
        logger.debug("Finished process_data")

    def process_match(self, m, excluded_levels):
        if random() < 0.5:
            player_A = m["B_name"]
            player_B = m["A_name"]
            result = 0
        else:
            player_A = m["A_name"]
            player_B = m["B_name"]
            result = 1

        match_id = m["match_id"]

        if m["tourney_level"] in excluded_levels or match_id < "2010":
            return

        if player_A not in self.player_match_dict:
            self.player_match_dict[player_A] = get_all_matches_for_player(
                player_A, self.conn
            )
        if player_B not in self.player_match_dict:
            self.player_match_dict[player_B] = get_all_matches_for_player(
                player_B, self.conn
            )

        player_A_matches = self.player_match_dict[player_A]
        player_B_matches = self.player_match_dict[player_B]

        player_A_matches = [
            player_A_matches[i]
            for i in range(len(player_A_matches))
            if player_A_matches[i]["match_id"] < match_id
        ]

        player_B_matches = [
            player_B_matches[i]
            for i in range(len(player_B_matches))
            if player_B_matches[i]["match_id"] < match_id
        ]

        data_list = get_match_stats(
            m, player_A, player_B, player_A_matches, player_B_matches
        )

        self.append_data(data_list, result)

    def append_data(self, data_list, result):
        if self.X[0][0] == None:
            self.X = np.array([data_list], dtype=np.float32)
        else:
            self.X = np.append(self.X, [data_list], axis=0)
        if self.Y[0] == None:
            self.Y = np.array([result], dtype=np.float32)
        else:
            self.Y = np.append(self.Y, [result], axis=0)

    def add_predictions(self, predictions, indices):
        for pred, index in zip(predictions, indices):
            if self.Y[index] == 0:
                pred = 1 - pred
            self.matches[index]["prediction"] = pred
            match_labels = labels if self.Y[index] == 1 else swapped_labels
            for i in range(len(match_labels)):
                self.matches[index][match_labels[i]] = self.X[index][i]
            self.matches[index]["result"] = self.Y[index]

    def save_to_csv(self, path):
        matches_df = pd.DataFrame(self.matches)
        matches_df.to_csv(path, index=False)


class NeuralNet:
    def __init__(self, match_data):
        self.X, self.Y = match_data.X, match_data.Y
        self.X_transformer = preprocessing.MinMaxScaler().fit(self.X)
        normal_X = self.X_transformer.transform(self.X)

        # Split into training and test sets
        tt_split = int(len(normal_X) * 8 / 10)
        p = np.random.permutation(len(normal_X))
        self.train_indices = p[:tt_split]
        self.test_indices = p[tt_split:]
        self.X_train = normal_X[self.train_indices]
        self.X_test = normal_X[self.test_indices]
        self.Y_train = self.Y[self.train_indices]
        self.Y_test = self.Y[self.test_indices]

    def create_model(
        self,
        layer_1_nodes,
        layer_2_nodes,
        layer_3_nodes,
        layer_4_nodes,
        layer_5_nodes,
        dropout_rate,
        regularisation,
    ):
        model = Sequential()
        layer_1 = Dense(
            layer_1_nodes, input_dim=len(self.X_train[0]), activation="relu"
        )
        model.add(layer_1)
        if dropout_rate != 0:
            model.add(Dropout(float(dropout_rate)))
        if layer_2_nodes != 0:
            layer_2 = Dense(
                layer_2_nodes,
                activation="relu",
                kernel_regularizer=regularizers.L1(l1=float(regularisation)),
                activity_regularizer=regularizers.L1(l1=float(regularisation)),
            )
            model.add(layer_2)
        if layer_3_nodes != 0:
            layer_3 = Dense(
                layer_3_nodes,
                activation="relu",
                kernel_regularizer=regularizers.L1(l1=float(regularisation)),
                activity_regularizer=regularizers.L1(l1=float(regularisation)),
            )
            model.add(layer_3)
        if layer_4_nodes != 0:
            layer_4 = Dense(
                layer_4_nodes,
                activation="relu",
                kernel_regularizer=regularizers.L1(l1=float(regularisation)),
                activity_regularizer=regularizers.L1(l1=float(regularisation)),
            )
            model.add(layer_4)
        if layer_5_nodes != 0:
            layer_5 = Dense(
                layer_5_nodes,
                activation="relu",
                kernel_regularizer=regularizers.L1(l1=float(regularisation)),
                activity_regularizer=regularizers.L1(l1=float(regularisation)),
            )
            model.add(layer_5)
        model.add(Dense(1, activation="sigmoid"))
        return model

    def train_model(self, model, alpha, epochs, batch_size):
        model.compile(
            loss="binary_crossentropy",
            optimizer=optimizers.Adam(learning_rate=float(alpha)),
            metrics=["accuracy"],
        )
        history = model.fit(
            self.X_train,
            self.Y_train,
            epochs=int(epochs),
            batch_size=int(batch_size),
            verbose=2,
            validation_data=(self.X_test, self.Y_test),
        )
        return history

    def visualize_training(self, history):
        plt.plot(history.history["loss"])
        plt.plot(history.history["val_loss"])
        plt.show()

    def save_model(self, model):
        model_filepath = (
            f"NN_model/NN_model_{datetime.now().strftime('%Y%m%d-%H%M')}.sav"
        )
        transformer_filepath = (
            f"transformer/NN_transformer_{datetime.now().strftime('%Y%m%d-%H%M')}.sav"
        )
        save_model(model, model_filepath)
        dump(self.X_transformer, transformer_filepath)

    def load_model(self, model_filepath, transformer_filepath):
        model = load_model(model_filepath)
        self.X_transformer = load(transformer_filepath)
        return model

    def predict_and_save(self, model, match_data, path):
        # predictions for the training data
        train_predictions = model.predict(self.X_train)
        match_data.add_predictions(train_predictions, self.train_indices)

        # predictions for the testing data
        test_predictions = model.predict(self.X_test)
        match_data.add_predictions(test_predictions, self.test_indices)

        match_data.save_to_csv(path)


def main(train=True, recalculate_stats=True):
    conn = sqlite3.connect("data/matches.sqlite")

    match_data = MatchData(conn, recalculate_stats)

    nn = NeuralNet(match_data)

    if train:
        new_structure = True
        while new_structure:
            layer_1_nodes = int(input("Number of nodes for layer 1: "))
            layer_2_nodes = int(input("Number of nodes for layer 2: "))
            layer_3_nodes = int(input("Number of nodes for layer 3: "))
            layer_4_nodes = int(input("Number of nodes for layer 4: "))
            layer_5_nodes = int(input("Number of nodes for layer 5: "))
            dropout_rate = float(input("Dropout rate: "))
            regularisation = float(input("Regularisation rate: "))

            model = nn.create_model(
                layer_1_nodes,
                layer_2_nodes,
                layer_3_nodes,
                layer_4_nodes,
                layer_5_nodes,
                dropout_rate,
                regularisation,
            )

            continue_training = True
            while continue_training:
                alpha = float(input("Alpha: "))
                epochs = int(input("Number of epochs: "))
                batch_size = int(input("Batch size: "))

                history = nn.train_model(model, alpha, epochs, batch_size)

                nn.visualize_training(history)

                continue_training_input = input(
                    "Do you want to continue training? (Y/n): "
                )
                if continue_training_input.lower() == "n":
                    continue_training = False

            new_structure_input = input(
                "Do you want to restart with a new structure? (Y/n): "
            )
            if new_structure_input.lower() == "n":
                new_structure = False

        nn.save_model(model)
        nn.predict_and_save(model, match_data, f"data/training_data.csv")
    else:
        model = nn.load_model("NN_model/NN_model_20230612-1157.sav")
        nn.predict_and_save(model, match_data, f"data/training_data.csv")


if __name__ == "__main__":
    main()
