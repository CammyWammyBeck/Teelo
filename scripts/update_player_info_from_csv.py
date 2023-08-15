import sqlite3
import csv
from scrape_player_data import save_player_data_to_sqlite


def update_player_info_from_csv(db_file, csv_file_path):
    conn = sqlite3.connect(db_file)

    player_data = {}

    # Read player data from the CSV file
    with open(csv_file_path, "r", newline="") as f:
        reader = csv.DictReader(f)
        for row in reader:
            player_data[row["player"]] = {
                "player": row["player"],
                "IOC": row["IOC"],
                "DOB": row["DOB"],
                "isActive": int(row["isActive"]),
            }

    # Update or insert the player data into the database
    print("Updating player data in database from CSV")
    save_player_data_to_sqlite(conn, player_data)
    print("Player data updated in database from CSV")

    conn.close()


if __name__ == "__main__":
    db_file = "data/matches.sqlite"
    csv_file_path = "data/player_data.csv"
    update_player_info_from_csv(db_file, csv_file_path)
