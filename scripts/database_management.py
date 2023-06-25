from time import sleep

import openpyxl
import pandas as pd

database_lock = False


def get_column_names(cursor, table_name):
    cursor.execute(f"PRAGMA table_info({table_name})")
    return [col_info[1] for col_info in cursor.fetchall()]


def write_to_db(c, conn, tourney_id, match_list):
    print(f"Writing {tourney_id} to the database.")

    c.execute(
        "DELETE FROM tennis_matches WHERE match_id LIKE ?",
        (f"{tourney_id}%",),
    )
    conn.commit()

    new_data = pd.DataFrame(match_list)
    existing_columns = get_column_names(c, "tennis_matches")

    for key in new_data.columns:
        if key not in existing_columns:
            c.execute(f"ALTER TABLE tennis_matches ADD COLUMN {key} TEXT")
            conn.commit()

    new_data.to_sql("tennis_matches", conn, if_exists="append", index=False)

    print(f"Finished writing {tourney_id} to the database.")


def write_to_pd(tourney, fixture_list):
    prediction_tourney_data = []

    print(f"Writing {tourney['tourney_id']} to the predictions database.")

    # Load existing data from the Excel file
    existing_data = pd.read_excel("data/predictions.xlsx", sheet_name="Predictions")

    for m in fixture_list:
        # Check if the match is already in the existing data
        tourney_id = m["match_id"][:13]
        is_existing = (
            (existing_data["match_id"].str[:13] == tourney_id)
            & (existing_data["A_name"] == m["A_name"])
            & (existing_data["B_name"] == m["B_name"])
            & (existing_data["round"] == m["round"])
        )

        if not is_existing.any():
            # The match does not exist in the Excel file, so add it to the list
            prediction_match = {}
            prediction_match["tourney_date"] = tourney["tourney_date"]
            prediction_match["match_id"] = m["match_id"]
            prediction_match["A_name"] = m["A_name"]
            prediction_match["B_name"] = m["B_name"]
            prediction_match["surface"] = tourney["tourney_surface"]
            prediction_match["tourney_level"] = tourney["tourney_level"]
            prediction_match["round"] = m["round"]
            prediction_match["tourney_name"] = tourney["tourney_name"]
            prediction_match["tourney_IOC"] = tourney["tourney_IOC"]

            prediction_tourney_data.append(prediction_match)

    prediction_tourney_data = pd.DataFrame(prediction_tourney_data)

    book = openpyxl.load_workbook("data/predictions.xlsx")
    ws = book["Predictions"]
    last_row = ws.max_row

    for i, row in prediction_tourney_data.iterrows():
        for j, item in enumerate(row):
            ws.cell(row=i + last_row + 1, column=j + 1, value=item)

    book.save("data/predictions.xlsx")

    print(f"Finished writing {tourney_id} to the predictions database.")
