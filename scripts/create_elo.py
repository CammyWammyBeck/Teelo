import sqlite3
import pandas as pd
from numpy import power
from config.config import ELO_CONSTANTS_LIST
from alive_progress import alive_bar
from scripts.stats import get_previous_elo, get_all_matches_for_player
from scripts.data_helpers import simplify_name

v = ELO_CONSTANTS_LIST


def calculate_elo(row, tourney_level):
    k_s = {
        "F": (v[0], v[1]),
        "C": (v[2], v[3]),
        "A": (v[4], v[5]),
        "M": (v[6], v[7]),
        "G": (v[8], v[9]),
    }
    k, s = k_s.get(tourney_level, (v[4], v[5]))

    A_previous_elo, B_previous_elo = row
    eA = 1 / (1 + power(10, ((B_previous_elo - A_previous_elo) / s)))
    eB = 1 / (1 + power(10, ((A_previous_elo - B_previous_elo) / s)))

    aA, aB = 1, 0
    A_new_elo = A_previous_elo + k * (aA - eA)
    B_new_elo = B_previous_elo + k * (aB - eB)

    return A_new_elo, B_new_elo


def create_elo(update=True):
    conn = sqlite3.connect("data/matches.sqlite")

    # Check if A_elo and B_elo columns already exist
    column_query = "PRAGMA table_info(tennis_matches);"
    columns_df = pd.read_sql_query(column_query, conn)
    existing_columns = set(columns_df["name"])

    if "A_elo" not in existing_columns:
        conn.execute("ALTER TABLE tennis_matches ADD COLUMN A_elo REAL;")
    if "B_elo" not in existing_columns:
        conn.execute("ALTER TABLE tennis_matches ADD COLUMN B_elo REAL;")
    conn.commit()

    # Check if simplified_name columns already exist
    if "A_simplified_name" not in existing_columns:
        conn.execute("ALTER TABLE tennis_matches ADD COLUMN A_simplified_name TEXT;")
    if "B_simplified_name" not in existing_columns:
        conn.execute("ALTER TABLE tennis_matches ADD COLUMN B_simplified_name TEXT;")

    query = "SELECT * FROM tennis_matches"

    if update:
        query += " WHERE A_elo IS NULL OR B_elo IS NULL"

    query += " ORDER BY match_id ASC"

    matches_df = pd.read_sql_query(query, conn)
    matches_df["A_simplified_name"] = matches_df["A_name"].apply(simplify_name)
    matches_df["B_simplified_name"] = matches_df["B_name"].apply(simplify_name)

    player_elo_dict = {}
    update_queries = []

    with alive_bar(len(matches_df)) as bar:
        for index, row in matches_df.iterrows():
            player_A_name, player_B_name = (
                row["A_simplified_name"],
                row["B_simplified_name"],
            )
            match_id = row["match_id"]

            if update:
                A_previous_elo = player_elo_dict.get(player_A_name, None)
                B_previous_elo = player_elo_dict.get(player_B_name, None)

                if A_previous_elo is None:
                    player_A_matches = get_all_matches_for_player(player_A_name, conn)
                    A_previous_elo = get_previous_elo(
                        player_A_name, match_id, player_A_matches
                    )
                    player_elo_dict[player_A_name] = A_previous_elo

                if B_previous_elo is None:
                    player_B_matches = get_all_matches_for_player(player_B_name, conn)
                    B_previous_elo = get_previous_elo(
                        player_B_name, match_id, player_B_matches
                    )
                    player_elo_dict[player_B_name] = B_previous_elo

            else:
                A_previous_elo = player_elo_dict.get(player_A_name, 1500)
                B_previous_elo = player_elo_dict.get(player_B_name, 1500)

            A_new_elo, B_new_elo = calculate_elo(
                (A_previous_elo, B_previous_elo),
                row["tourney_level"],
            )

            matches_df.at[index, "A_elo"] = A_new_elo
            matches_df.at[index, "B_elo"] = B_new_elo

            update_queries.append(
                (A_new_elo, B_new_elo, player_A_name, player_B_name, row["match_id"])
            )
            player_elo_dict[player_A_name] = A_new_elo
            player_elo_dict[player_B_name] = B_new_elo

            bar()

    if update and update_queries:
        conn.executemany(
            "UPDATE tennis_matches SET A_elo = ?, B_elo = ?, A_simplified_name = ?, B_simplified_name = ? WHERE match_id = ?;",
            update_queries,
        )
        conn.commit()
    if not update:
        matches_df.to_sql("tennis_matches", conn, if_exists="replace", index=False)

    conn.close()


if __name__ == "__main__":
    create_elo(update=True)
