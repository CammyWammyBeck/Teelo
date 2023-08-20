import tensorflow as tf
from tf_agents.networks import q_network
from tf_agents.agents.dqn import dqn_agent
from tf_agents.utils import common
import gym
from gym import spaces
from config.config import STAT_LABELS
from sklearn.model_selection import train_test_split

import pandas as pd


class TennisBettingEnv(gym.Env):
    def __init__(self, data):
        super(TennisBettingEnv, self).__init__()

        # Define action and observation space
        self.action_space = spaces.Discrete(
            3
        )  # 0: Don't bet, 1: Bet on player A, 2: Bet on player B
        self.observation_space = spaces.Box(low=0, high=1, shape=(100,), dtype=float)

        self.data = data
        self.current_step = 0

    def step(self, action):
        # Implement the logic to simulate the step and return the reward
        # You will call your custom reward function here

        # ...

        return observation, reward, done, {}

    def reset(self):
        # Reset the environment to the initial state
        self.current_step = 0
        return self.data.iloc[self.current_step]


file_path = "data/predictions_test.xlsx"
sheet_name = "predictions"
data = pd.read_excel(file_path, sheet_name=sheet_name)

# Assuming labels are the headers
labels = STAT_LABELS

X = []
Y = []
for match in data:
    for label in labels:
        if match["Winner"] != "A" or match["Winner"] != "B":
            continue
        X.append(match[label])
        if match["Winner"] == "A":
            Y.append(1)
        else:
            Y.append(0)

# Splitting the data
X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size=0.2)

# Define Q-Network
q_net = q_network.QNetwork(
    TennisBettingEnv.observation_space.shape, TennisBettingEnv.action_space.n
)

optimizer = tf.compat.v1.train.AdamOptimizer(learning_rate=1e-3)
train_step_counter = tf.Variable(0)

agent = dqn_agent.DqnAgent(
    TennisBettingEnv.time_step_spec(),
    TennisBettingEnv.action_space,
    q_network=q_net,
    optimizer=optimizer,
    td_errors_loss_fn=common.element_wise_squared_loss,
    train_step_counter=train_step_counter,
)

agent.initialize()
