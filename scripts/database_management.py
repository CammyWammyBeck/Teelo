from time import sleep
from datetime import datetime

import openpyxl
import pandas as pd
from alive_progress import alive_bar

database_lock = False


def get_column_names(cursor, table_name):
    cursor.execute(f"PRAGMA table_info({table_name})")
    return [col_info[1] for col_info in cursor.fetchall()]


def write_to_db(c, conn, match_list):
    # Get unique list of tourney_ids from the match_list match_ids
    tourney_ids = list(
        set(["_".join(m["match_id"].split("_")[:2]) for m in match_list])
    )

    print("Deleting existing data from the database.")
    if tourney_ids:  # Make sure there is at least one id to avoid a malformed query
        query = "DELETE FROM tennis_matches WHERE " + " OR ".join(
            f"match_id LIKE '{tourney_id}%'" for tourney_id in tourney_ids
        )
        c.execute(query)
        conn.commit()

    new_data = pd.DataFrame(match_list)
    existing_columns = get_column_names(c, "tennis_matches")

    print("Writing new data to the database.")
    for key in new_data.columns:
        if key not in existing_columns:
            c.execute(f"ALTER TABLE tennis_matches ADD COLUMN {key} TEXT")
            conn.commit()

    new_data.to_sql("tennis_matches", conn, if_exists="append", index=False)

    print(f"Database updated with data from {len(tourney_ids)} tournaments.")


def write_to_pd(fixture_list):
    prediction_tourney_data = []

    if not fixture_list:
        return

    print("Writing new data to the Excel file.")

    # Load existing data from the Excel file
    existing_data = pd.read_excel("data/predictions.xlsx", sheet_name="Predictions")

    for m in fixture_list:
        # Check if the match is already in the existing data
        tourney_id = "-".join(m["match_id"].split("-")[:2])
        is_existing = (
            ("-".join(existing_data["match_id"].split("-")[:2]) == tourney_id)
            & (existing_data["A_name"] == m["A_name"])
            & (existing_data["B_name"] == m["B_name"])
            & (existing_data["round"] == m["round"])
        )

        if not is_existing.any():
            # The match does not exist in the Excel file, so add it to the list
            prediction_match = {}
            prediction_match["tourney_date"] = m["match_id"].split("-")[0]
            prediction_match["match_id"] = m["match_id"]
            prediction_match["A_name"] = m["A_name"]
            prediction_match["B_name"] = m["B_name"]
            prediction_match["surface"] = m["tourney_surface"]
            prediction_match["tourney_level"] = m["tourney_level"]
            prediction_match["round"] = m["round"]
            prediction_match["tourney_name"] = m["tourney_name"]
            prediction_match["tourney_IOC"] = m["tourney_IOC"]

            prediction_tourney_data.append(prediction_match)

    prediction_tourney_data = pd.DataFrame(prediction_tourney_data)

    book = openpyxl.load_workbook("data/predictions.xlsx")
    ws = book["Predictions"]
    last_row = ws.max_row

    for i, row in prediction_tourney_data.iterrows():
        for j, item in enumerate(row):
            ws.cell(row=i + last_row + 1, column=j + 1, value=item)

    book.save("data/predictions.xlsx")

    print(f"Excel file updated with data from {len(fixture_list)} matches.")
