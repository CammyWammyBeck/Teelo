import math
from random import random
import sqlite3
import pandas as pd

from numpy import Infinity, power

from utilities.stats import get_quarters_since_played

GENERATIONS = 50
POPULATION_SIZE = 50
MUTATION_RATE = 0.4
K_ADJUST = 8
S_ADJUST = 40


def main():
    conn = sqlite3.connect('data/matches.sqlite')

    df = pd.read_sql_query(
        "SELECT * FROM tennis_matches ORDER BY match_id", conn)
    myresult = df.to_dict('records')

    start_values = [{"values": [46, 309, 36, 355, 28, 422, 27, 459, 30, 359], "sse": Infinity},
                    {"values": [46, 309, 36, 355, 28, 423, 26, 450, 31, 363], "sse": Infinity},
                    {"values": [46, 309, 36, 355, 28, 423, 26, 450, 30, 363], "sse": Infinity}]
    best_values = start_values
    best_sse = Infinity
    level_best_sse = {
        "F": Infinity,
        "C": Infinity,
        "A": Infinity,
        "M": Infinity,
        "G": Infinity
    }

    for i in range(GENERATIONS):
        values = mutate_values(best_values)
        population_best_sse = best_sse
        ind_counter = 0
        for val in values:
            v = val["values"]
            player_elo_data = {}
            sum_of_squares = 0
            count = 0
            level_sse = {
                "F": 0,
                "C": 0,
                "A": 0,
                "M": 0,
                "G": 0
            }
            level_count = {
                "F": 0,
                "C": 0,
                "A": 0,
                "M": 0,
                "G": 0
            }
            for x in myresult:
                player_A = x["A_name"].title()
                player_B = x["B_name"].title()
                match_id = x["match_id"]
                A_last_elo = 1500
                B_last_elo = 1500

                if player_A in player_elo_data:
                    A_last_elo_data = player_elo_data[player_A][-1]
                    A_last_elo = A_last_elo_data["elo"]
                else:
                    player_elo_data[player_A] = []

                if player_B in player_elo_data:
                    B_last_elo_data = player_elo_data[player_B][-1]
                    B_last_elo = B_last_elo_data["elo"]
                else:
                    player_elo_data[player_B] = []

                k = 25
                s = 300

                tourney_level = x['tourney_level']
                if tourney_level == 'F':
                    k = v[0]
                    s = v[1]
                elif tourney_level == 'C':
                    k = v[2]
                    s = v[3]
                elif tourney_level == 'A':
                    k = v[4]
                    s = v[5]
                elif tourney_level == 'M':
                    k = v[6]
                    s = v[7]
                elif tourney_level == 'G':
                    k = v[8]
                    s = v[9]

                eA = 1 / (1 + power(10, ((B_last_elo - A_last_elo) / s)))
                eB = 1 / (1 + power(10, ((A_last_elo - B_last_elo) / s)))

                aA = 1
                aB = 0

                if match_id > "2010":
                    squared_error = (aA - eA)**2
                    sum_of_squares = sum_of_squares + squared_error
                    count = count + 1
                    if x["tourney_level"] in level_sse:
                        level_sse[x["tourney_level"]
                                  ] = level_sse[x["tourney_level"]] + squared_error
                        level_count[x["tourney_level"]
                                    ] = level_count[x["tourney_level"]] + 1

                A_new_elo = A_last_elo + k * (aA - eA)
                B_new_elo = B_last_elo + k * (aB - eB)

                player_elo_data[player_A].append(
                    {"match_id": match_id, "elo": A_new_elo})
                player_elo_data[player_B].append(
                    {"match_id": match_id, "elo": B_new_elo})

            val["sse"] = sum_of_squares / count
            if val["sse"] < population_best_sse:
                population_best_sse = val["sse"]
                for l in level_best_sse:
                    if not level_count[l] == 0:
                        level_best_sse[l] = level_sse[l] / level_count[l]
            print("Ind: " + str(ind_counter), v, round(val["sse"], 6), round(
                population_best_sse, 6), round(best_sse, 6), count)
            ind_counter = ind_counter + 1

        if population_best_sse < best_sse:
            best_sse = population_best_sse
            best_values = sorted(values, key=lambda d: d['sse'])[:3]

        print("Gen: " + str(i), best_values, best_sse)
        for l in level_best_sse:
            print(l, ": ", level_best_sse[l])


def mutate_values(values):
    all_vals = []
    for val in values:
        v = val["values"]
        for j in range(int(POPULATION_SIZE / len(values))):
            vals = []
            for i in range(0, len(v), 2):
                temp1 = v[i]
                temp2 = v[i+1]
                rnd = random()
                rnd1 = random()
                if rnd < MUTATION_RATE:
                    temp1 = math.floor(
                        temp1 + math.floor(random() * K_ADJUST) - K_ADJUST / 2)
                if rnd1 < MUTATION_RATE:
                    temp2 = math.floor(
                        temp2 + math.floor(random() * S_ADJUST) - S_ADJUST / 2)
                vals.append(temp1)
                vals.append(temp2)
            all_vals.append(vals)

    val_dict = []
    for val in all_vals:
        val_dict.append({"values": val, "sse": Infinity})
    for val in values:
        val_dict.append(val)

    return val_dict


if __name__ == "__main__":
    main()
