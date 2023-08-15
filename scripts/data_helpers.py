import csv
import json
from datetime import datetime, timedelta
import re
from functools import lru_cache
import requests
import sqlite3
import pandas as pd

from dateutil.relativedelta import relativedelta


def load_json(json_file_path):
    g = open(json_file_path, "r", encoding="utf-8-sig")
    data = json.load(g)
    g.close()
    return data


def csv_to_array(csv_file_path):
    db = []

    with open(csv_file_path, encoding="utf-8-sig", mode="r") as csv_file:
        csv_reader = csv.DictReader(csv_file)

        for row in csv_reader:
            db.append(row)

    return db


def data_to_json(data, json_file_path):
    with open(json_file_path, "w", encoding="utf-8-sig") as json_file:
        json_string = json.dumps(data, indent=4)
        json_file.write(json_string)


def randomise_games(db):
    rand = 0
    for m in db:
        temp_array = m.copy()
        A_renames = [
            "A_id",
            "A_name",
            "A_hand",
            "A_ioc",
            "A_age",
            "A_svpt",
            "A_1stIn",
            "A_2ndWon",
            "A_rank_points",
        ]
        B_renames = [
            "B_id",
            "B_name",
            "B_hand",
            "B_ioc",
            "B_age",
            "B_svpt",
            "B_1stIn",
            "B_2ndWon",
            "B_rank_points",
        ]
        m["result"] = "A"
        if rand % 2 == 1:
            for i in range(len(A_renames)):
                m["result"] = "B"
                m[A_renames[i]] = temp_array[B_renames[i]]
                m[B_renames[i]] = temp_array[A_renames[i]]
        rand += 1
    return db


def matches_by_player(bm, bp):
    for m in bm:
        if m["A_name"] in bp:
            bp[m["A_name"]].append(m)
        else:
            bp[m["A_name"]] = [m]
        if m["B_name"] in bp:
            bp[m["B_name"]].append(m)
        else:
            bp[m["B_name"]] = [m]

    return bp


def create_player_info(bp):
    pi = []
    p = ""
    i = 0
    for key in bp:
        pi.append({})
        if bp[key][-1]["A_name"] == key:
            p = "A"
        elif bp[key][-1]["B_name"] == key:
            p = "B"

        pi[i]["player_id"] = bp[key][-1][f"{p}_id"]
        pi[i]["player_name"] = bp[key][-1][f"{p}_name"]
        pi[i]["player_hand"] = bp[key][-1][f"{p}_hand"]
        try:
            pi[i]["player_birthday"] = (
                datetime.strptime(bp[key][-1][f"tourney_date"], "%Y%m%d")
                - relativedelta(years=int(float(bp[key][-1][f"{p}_age"])))
            ).strftime("%Y%m%d")
        except:
            pi[i]["player_birthday"] = (
                datetime.now() - relativedelta(years=25)
            ).strftime("%Y%m%d")
        pi[i]["IOC"] = bp[key][-1][f"{p}_ioc"]
        i += 1

    return pi


@lru_cache(maxsize=None)
def simplify_name(name):
    simplified_name = re.sub(r"[^A-Za-z0-9]+", "", name)
    return simplified_name.lower()


def get_ioc_code(location):
    """Returns the IOC code of a location, if it exists.
    If it doesn't exist, returns None."""

    # If location is a 3-letter IOC code, return it
    if len(location) == 3 and location.isupper():
        return location

    part1 = ""
    part2 = ""

    if ", " in location:  # If it's a format like 'Stockholm, Sweden'
        part1, part2 = location.split(", ", 1)
    else:  # It's a single part location like 'Costa do Sauipe' or 's-Hertogenbosch'
        part1 = location

    # Check if part1 is a country by calling the REST Countries API
    response = requests.get(
        f"https://restcountries.com/v3.1/name/{part1}?fullText=true",
    )
    if response.status_code == 200:  # If status is OK, it means it's a country
        data = response.json()
        # Not all countries may have an IOC code
        return data[0].get("cioc", data[0].get("cca3", None))

    # If part1 is not a country, we check if part2 is a country, if it exists
    if part2:
        response = requests.get(
            f"https://restcountries.com/v3.1/name/{part2}?fullText=true",
        )
        if response.status_code == 200:  # If status is OK, it means it's a country
            data = response.json()
            # Not all countries may have an IOC code
            return data[0].get("cioc", data[0].get("cca3", None))

    # If we are here, either both parts were not countries or we had only one part and it wasn't a country
    # We now treat the part1 as a city and use Nominatim API to get the country information from the city
    response = requests.get(
        f"https://nominatim.openstreetmap.org/search?city={part1}&format=json"
    )
    if response.status_code == 200:
        data = response.json()
        if data:  # if data is not empty
            country = data[0]["display_name"].split(", ")[-1]
            response = requests.get(
                f"https://restcountries.com/v3.1/name/{country}?fullText=true"
            )
            if response.status_code == 200:
                data = response.json()
                # Not all countries may have an IOC code
                return data[0].get("cioc", data[0].get("cca3", None))

    # If we are here, we couldn't find the country
    print(f"Couldn't find the country for {location}")
    return None


db_file = "../matches.sqlite"


def get_data_from_sqlite(start_year=None):
    with sqlite3.connect(db_file) as conn:
        query = "SELECT * FROM tennis_matches"
        if start_year:
            query += f" WHERE match_id >= {str(start_year)}"
        data = pd.read_sql_query(query, conn)
        return data.to_dict("records")


def save_data_to_sqlite(matches):
    df = pd.DataFrame(matches)
    with sqlite3.connect(db_file) as conn:
        existing_columns = [
            col[1] for col in conn.execute("PRAGMA table_info(tennis_matches)")
        ]

        for col in df.columns:
            if col not in existing_columns:
                conn.execute(f"ALTER TABLE tennis_matches ADD COLUMN {col} TEXT")

        columns = ", ".join(df.columns)
        placeholders = ", ".join("?" * len(df.columns))

        insert_or_replace_query = (
            f"INSERT OR REPLACE INTO tennis_matches ({columns}) VALUES ({placeholders})"
        )

        conn.executemany(insert_or_replace_query, df.values.tolist())

    print(f"SQLite database {db_file} updated with data from matches")


def get_match_date(match_id, round, level):
    """Convert match id in the format TOURNEYSTARTDATE_TOURNEYNUM_MATCHNUM to a datetime object"""
    tourney_date = datetime.strptime(match_id.split("_")[0], "%Y%m%d")
    if level == "G":
        round_adjustment = {
            "Q1": -3,
            "Q2": -2,
            "Q3": -1,
            "R128": 0,
            "R64": 3,
            "R32": 5,
            "R16": 7,
            "QF": 9,
            "SF": 11,
            "F": 13,
        }
        match_number_adjustment = {
            "SF": 237,
            "QF": 234,
            "R16": 228,
            "R32": 216,
            "R64": 192,
            "R128": 144,
        }
    elif level == "M":
        round_adjustment = {
            "Q1": -2,
            "Q2": -1,
            "R64": 0,
            "R32": 2,
            "R16": 3,
            "QF": 4,
            "SF": 5,
            "F": 6,
        }
        match_number_adjustment = {
            "R64": 192,
        }
    else:
        round_adjustment = {
            "Q1": -2,
            "Q2": -1,
            "R32": 0,
            "R16": 2,
            "QF": 4,
            "SF": 5,
            "F": 6,
        }
        match_number_adjustment = {
            "R16": 228,
            "R32": 216,
        }

    adjustment = round_adjustment.get(round, 0)
    match_number_half = match_number_adjustment.get(round, 999)
    if int(match_id.split("_")[2]) > match_number_half:
        adjustment += 1

    start_day_adjustment = {
        1: -1,
        2: -2,
        3: -3,
        4: 3,
        5: 2,
        6: 1,
    }

    if tourney_date.weekday() != 0:
        adjustment += start_day_adjustment.get(tourney_date.weekday(), 0)

    return tourney_date + relativedelta(days=adjustment)
