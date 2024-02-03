import logging
import sqlite3
from datetime import datetime
from random import random
import copy
from sklearn.inspection import permutation_importance

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from alive_progress import alive_bar
from joblib import dump, load
from keras import optimizers, regularizers
from keras.layers import Dense, Dropout
from keras.models import Sequential, load_model, save_model
from keras.callbacks import Callback
from sklearn import preprocessing
from sklearn.metrics import f1_score, precision_score, recall_score
from tqdm import tqdm

from config.config import STAT_LABELS
from scripts.stats import get_all_matches_for_player, get_match_stats
from sklearn.feature_selection import RFE
from sklearn.linear_model import LogisticRegression

labels = STAT_LABELS

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
        query = "SELECT * FROM tennis_matches WHERE match_id >= '2000' AND tourney_level != 'F' ORDER BY match_id ASC"
        matches_df = pd.read_sql_query(query, self.conn)
        return matches_df.to_dict("records")

    def process_data(self):
        excluded_levels = ["F"]
        X_list = []  # List to hold arrays of data_list for each chunk
        Y_list = []  # List to hold arrays of result for each chunk
        with alive_bar(len(self.matches), title="Processing matches") as bar:
            for m in self.matches:
                if m["tourney_level"] in excluded_levels:
                    bar()
                    continue

                X, Y = self.process_match(m, 1)
                # Append chunk's data_list and result to the lists
                X_list.append(X)
                Y_list.append(Y)

                swapped_match = copy.deepcopy(m)
                (
                    swapped_match["A_name"],
                    swapped_match["B_name"],
                    swapped_match["A_simplified_name"],
                    swapped_match["B_simplified_name"],
                ) = (
                    m["B_name"],
                    m["A_name"],
                    m["B_simplified_name"],
                    m["A_simplified_name"],
                )

                X, Y = self.process_match(swapped_match, 0)
                # Append chunk's data_list and result to the lists
                X_list.append(X)
                Y_list.append(Y)

                bar()

        # Concatenate all chunk arrays into one array
        self.X = np.array(X_list) if len(X_list) > 0 else np.array([None])
        self.Y = np.array(Y_list) if len(Y_list) > 0 else np.array([None])

    def process_match(self, m, result):
        player_A = m["A_simplified_name"]
        player_B = m["B_simplified_name"]

        match_id = m["match_id"]

        if match_id < "2000":
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

        return data_list, result

    def load_from_csv(self, file_path, chunksize=10**6):
        X_list = []  # List to hold arrays of data_list for each chunk
        Y_list = []  # List to hold arrays of result for each chunk
        matches_list = []  # List to hold each chunk

        for chunk in pd.read_csv(file_path, chunksize=chunksize):
            chunk_data = []
            chunk_results = []
            matches_list.append(chunk.to_dict("records"))
            for index, match in tqdm(
                chunk.iterrows(), desc="Loading matches", smoothing=0.8
            ):
                if match["match_id"] > "202305":
                    continue

                data_list = [match[label] for label in labels]
                result = match["result"]
                chunk_data.append(data_list)
                chunk_results.append(result)

                # Create new record for B vs A
                swapped_data_list = []
                for label in labels:
                    if label.startswith("A_"):
                        swapped_data_list.append(match[label.replace("A_", "B_")])
                    elif label.startswith("B_"):
                        swapped_data_list.append(match[label.replace("B_", "A_")])
                    else:
                        swapped_data_list.append(match[label])
                swapped_result = 1 - result
                chunk_data.append(swapped_data_list)
                chunk_results.append(swapped_result)

            # Append chunk's data_list and result to the lists
            X_list.append(np.array(chunk_data, dtype=np.float32))
            Y_list.append(np.array(chunk_results, dtype=np.float32))

        # Concatenate all chunk arrays into one array
        self.X = np.concatenate(X_list, axis=0) if len(X_list) > 0 else np.array([None])
        self.Y = np.concatenate(Y_list, axis=0) if len(Y_list) > 0 else np.array([None])

        # Concatenate all chunks into one list
        matches = [item for sublist in matches_list for item in sublist]
        return matches

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
        # Initialize a new list to hold unique matches
        unique_matches = []

        # Iterate over pairs of matches to de-duplicate
        for i in range(0, len(self.Y), 2):
            original_match = self.matches[i // 2]
            copied_match = copy.deepcopy(original_match)

            # If the result is 0, swap labels for player A and player B
            if self.Y[i] == 0:
                for label in [
                    "A_name",
                    "B_name",
                    "A_simplified_name",
                    "B_simplified_name",
                ]:
                    if "A_" in label:
                        original_match[label] = copied_match[label.replace("A_", "B_")]
                    elif "B_" in label:
                        original_match[label] = copied_match[label.replace("B_", "A_")]

            # Update match statistics and result
            for j, label in enumerate(labels):
                original_match[label] = self.X[i][j]
            original_match["result"] = self.Y[i]

            # Append the de-duplicated match to the list
            unique_matches.append(original_match)

        # Convert the list of unique matches to a DataFrame and save it to a CSV file
        unique_matches_df = pd.DataFrame(unique_matches)
        unique_matches_df.to_csv(path, index=False)


class CustomModelCheckpoint(Callback):
    def __init__(self, model, **kwargs):
        super().__init__(**kwargs)
        self.model = model
        self.best_weights = None
        self.best_loss = float("inf")

    def on_epoch_end(self, epoch, logs=None):
        current_val_loss = logs.get("val_loss")
        if current_val_loss < self.best_loss:
            self.best_loss = current_val_loss
            self.best_weights = self.model.get_weights()
            print("Saving model with loss", current_val_loss)


class NeuralNet:
    def __init__(self, match_data, num_features):
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

        # Set up logging
        logging.basicConfig(filename="training_logs.txt", level=logging.INFO)
        logging.info("Initialized NeuralNet")

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
        if dropout_rate != 0:
            model.add(Dropout(float(dropout_rate)))
        if layer_3_nodes != 0:
            layer_3 = Dense(
                layer_3_nodes,
                activation="relu",
                kernel_regularizer=regularizers.L1(l1=float(regularisation)),
                activity_regularizer=regularizers.L1(l1=float(regularisation)),
            )
            model.add(layer_3)
        if dropout_rate != 0:
            model.add(Dropout(float(dropout_rate)))
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

        logging.info(
            "Created model with parameters: layer_1_nodes=%s, layer_2_nodes=%s, layer_3_nodes=%s, layer_4_nodes=%s, layer_5_nodes=%s, dropout_rate=%s, regularisation=%s",
            layer_1_nodes,
            layer_2_nodes,
            layer_3_nodes,
            layer_4_nodes,
            layer_5_nodes,
            dropout_rate,
            regularisation,
        )

        return model

    def train_model(self, model, alpha, epochs, batch_size):
        model.compile(
            loss="binary_crossentropy",
            optimizer=optimizers.Adam(learning_rate=float(alpha)),
            metrics=["accuracy"],
        )

        checkpoint = CustomModelCheckpoint(model)

        history = model.fit(
            self.X_train,
            self.Y_train,
            epochs=int(epochs),
            batch_size=int(batch_size),
            verbose=2,
            validation_data=(self.X_test, self.Y_test),
            callbacks=[checkpoint],
        )

        # store the model with the best weights
        self.best_model = model
        self.best_model.set_weights(checkpoint.best_weights)

        # Calculate metrics on test data
        test_predictions = (model.predict(self.X_test) > 0.5).astype("int32")
        precision = precision_score(self.Y_test, test_predictions)
        recall = recall_score(self.Y_test, test_predictions)
        f1 = f1_score(self.Y_test, test_predictions)

        logging.info(
            "Trained model for %s epochs. Training loss: %s, Training accuracy: %s, Validation loss: %s, Validation accuracy: %s, Precision: %s, Recall: %s, F1-score: %s",
            epochs,
            round(history.history["loss"][-1], 5),
            round(history.history["accuracy"][-1], 5),
            round(history.history["val_loss"][-1], 5),
            round(history.history["val_accuracy"][-1], 5),
            round(precision, 5),
            round(recall, 5),
            round(f1, 5),
        )

        return history

    def feature_importance(self, model, n_features):
        # Compute permutation importance
        result = permutation_importance(
            model,
            self.X_test,
            self.Y_test,
            scoring="r2",
            n_repeats=10,
            random_state=42,
            n_jobs=1,
        )

        # Get indices of features sorted by importance
        sorted_indices = result.importances_mean.argsort()[::-1]

        # Print feature importance
        print("Feature Importance:")
        for i in sorted_indices[:n_features]:
            if result.importances_mean[i] - 2 * result.importances_std[i] > 0:
                print(
                    f"Feature {i} - importance: {result.importances_mean[i]:.3f}, std: {result.importances_std[i]:.3f}"
                )

        # Create feature selection mask
        mask = [False] * len(self.X_test.columns)
        for i in sorted_indices[:n_features]:
            mask[i] = True

        return mask

    def visualize_training(self, history):
        plt.plot(history.history["loss"])
        plt.plot(history.history["val_loss"])
        plt.show()

    def save_model(self):
        model_filepath = (
            f"models/NN_model/NN_model_{datetime.now().strftime('%Y%m%d-%H%M')}.sav"
        )
        transformer_filepath = f"models/transformer/NN_transformer_{datetime.now().strftime('%Y%m%d-%H%M')}.sav"
        save_model(self.best_model, model_filepath)
        dump(self.X_transformer, transformer_filepath)

        logging.info(
            "Saved model to %s and transformer to %s",
            model_filepath,
            transformer_filepath,
        )

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


def main(train=True, recalculate_stats=False):
    conn = sqlite3.connect("data/matches.sqlite")

    match_data = MatchData(conn, recalculate_stats)

    if recalculate_stats:
        match_data.save_to_csv("data/training_data.csv")

    nn = NeuralNet(match_data, 150)

    if train:
        (new_structure) = True
        while new_structure:
            try:
                layer_1_nodes = int(input("Number of nodes for layer 1: "))
                layer_2_nodes = int(input("Number of nodes for layer 2: "))
                layer_3_nodes = int(input("Number of nodes for layer 3: "))
                layer_4_nodes = int(input("Number of nodes for layer 4: "))
                layer_5_nodes = int(input("Number of nodes for layer 5: "))
                (dropout_rate) = float(input("Dropout rate: "))
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
                    try:
                        alpha = float(input("Alpha: "))
                        epochs = int(input("Number of epochs: "))
                        (batch_size) = int(input("Batch size: "))

                        history = nn.train_model(model, alpha, epochs, batch_size)

                        nn.visualize_training(history)
                    except KeyboardInterrupt:
                        print("Training stopped.")
                        continue_training = False
                    else:
                        continue_training_input = input(
                            "Do you want to continue training? (Y/n): "
                        )
                        if continue_training_input.lower() == "n":
                            continue_training = False

                # mask = nn.feature_importance(model, 80)
                new_structure_input = input(
                    "Do you want to restart with a new structure? (Y/n): "
                )
                if new_structure_input.lower() == "n":
                    (new_structure) = False
            except KeyboardInterrupt:
                print("You cannot stop the structure creation process.")
                continue

        save_model_input = input("Do you want to save the model? (Y/n): ")
        if save_model_input.lower() == "y":
            nn.save_model()
            # nn.predict_and_save(model, match_data, f"data/training_data.csv")
    else:
        model = nn.load_model("NN_model/NN_model_20230612-1157.sav")
        nn.predict_and_save(model, match_data, f"data/training_data.csv")


if __name__ == "__main__":
    main(recalculate_stats=True)
