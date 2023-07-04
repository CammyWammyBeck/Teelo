import os
import platform
import queue
import sqlite3
import sys
import threading
import traceback
from datetime import datetime, timedelta
from time import sleep

import pandas as pd
import undetected_chromedriver as uc
from bs4 import BeautifulSoup as BS
from screeninfo import get_monitors
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

from scripts.data_helpers import get_ioc_code
from scripts.database_management import write_to_db, write_to_pd, database_lock

pd.options.mode.chained_assignment = None
stop_threads = False


class AnyEC:
    """Use with WebDriverWait to combine expected_conditions
    in an OR.
    """

    def __init__(self, *args):
        self.ecs = args

    def __call__(self, driver):
        for fn in self.ecs:
            try:
                res = fn(driver)
                if res:
                    return True
                    # Or return res if you need the element found
            except:
                pass


def get_round_string(round_data):
    round = ""
    if round_data == "Finals" or round_data == "Final":
        round = "F"
    elif round_data == "Semi-Finals" or round_data == "Semifinals":
        round = "SF"
    elif round_data == "Quarter-Finals" or round_data == "Quarterfinals":
        round = "QF"
    elif round_data == "Round of 16":
        round = "R16"
    elif round_data == "Round of 32":
        round = "R32"
    elif round_data == "Round of 64":
        round = "R64"
    elif round_data == "Round of 128":
        round = "R128"
    elif round_data == "4th Round Qualifying":
        round = "Q4"
    elif round_data == "3rd Round Qualifying":
        round = "Q3"
    elif round_data == "2nd Round Qualifying":
        round = "Q2"
    elif round_data == "1st Round Qualifying":
        round = "Q1"
    elif round_data == "Round Robin":
        round = "RR"
    return round


def fill_match_numbers(match_list, tourney):
    count = 239
    current_round = "F"
    for match in match_list:
        if match["round"] != current_round:
            match match["round"]:
                case "F":
                    count = 239
                case "SF":
                    count = 238
                case "QF":
                    count = 236
                case "R16":
                    count = 232
                case "R32":
                    count = 224
                case "R64":
                    count = 208
                case "R128":
                    count = 176
                case "Q3":
                    count = 112
                case "Q2":
                    count = 96
                case "Q1":
                    count = 64
                case _:
                    count = 0
            current_round = match["round"]

        match["match_id"] = f"{tourney['tourney_id']}_{str(count).zfill(3)}"
        count -= 1

    return match_list


def get_match_stats(driver, match):
    tourney_read = False
    error_count = 0
    while not tourney_read:
        try:
            driver.get(f"https://www.atptour.com{match['match_link']}")
            sleep(1.5)
            w = WebDriverWait(driver, 10).until(
                AnyEC(
                    EC.presence_of_element_located(
                        (By.CLASS_NAME, "match-stats-table")
                    ),
                    EC.presence_of_element_located((By.CLASS_NAME, "statTileWrapper")),
                )
            )

            tourney_match_data = BS(driver.page_source, features="html.parser")

            if tourney_match_data.find(class_="match-stats-table"):
                stats_data = tourney_match_data.find_all(class_="match-stats-row")

                for stat_data in stats_data:
                    stat_name = (
                        stat_data.find(class_="match-stats-label")
                        .getText()
                        .lower()
                        .strip()
                        .replace(" ", "_")
                        .strip()
                    )
                    if stat_data.find(class_="match-stats-number-left").find("a"):
                        A_stat = (
                            stat_data.find(class_="match-stats-number-left")
                            .find("a")
                            .getText()
                            .strip()
                        )
                        B_stat = (
                            stat_data.find(class_="match-stats-number-right")
                            .find("a")
                            .getText()
                            .strip()
                        )
                        for s in [A_stat, B_stat]:
                            if " " in s:
                                s = s.split(" ")[0]
                    else:
                        if stat_data.find(class_="match-stats-number-left").find(
                            class_="stat-breakdown"
                        ):
                            A_stat = (
                                stat_data.find(class_="match-stats-number-left")
                                .find(class_="stat-breakdown")
                                .getText()
                                .strip()
                            )
                        else:
                            A_stat = (
                                stat_data.find(class_="match-stats-number-left")
                                .find("span")
                                .getText()
                                .strip()
                            )
                        if stat_data.find(class_="match-stats-number-right").find(
                            class_="stat-breakdown"
                        ):
                            B_stat = (
                                stat_data.find(class_="match-stats-number-right")
                                .find(class_="stat-breakdown")
                                .getText()
                                .strip()
                            )
                        else:
                            B_stat = (
                                stat_data.find(class_="match-stats-number-right")
                                .find("span")
                                .getText()
                                .strip()
                            )
                        A_stat = A_stat.replace("(", "").replace(")", "")
                        B_stat = B_stat.replace("(", "").replace(")", "")
                    A_stat = A_stat.replace("/", "_")
                    B_stat = B_stat.replace("/", "_")
                    match[f"A_{stat_name}"] = A_stat
                    match[f"B_{stat_name}"] = B_stat

            elif tourney_match_data.find(class_="statTileWrapper"):
                stats_data = tourney_match_data.find_all(class_="statTileWrapper")

                for stat_data in stats_data:
                    stat_name = (
                        stat_data.find(class_="labelWrappper")
                        .find(class_="labelBold")
                        .getText()
                        .lower()
                        .replace(" ", "_")
                        .strip()
                    )
                    if stat_name == "first_serve":
                        stat_name = "1st_serve"
                    if stat_data.find(class_="player1").find("a"):
                        A_stat = (
                            stat_data.find(class_="player1").find("a").getText().strip()
                        )
                        B_stat = (
                            stat_data.find(class_="player2").find("a").getText().strip()
                        )
                    else:
                        A_stat = (
                            stat_data.find(class_="player1")
                            .find("span")
                            .getText()
                            .strip()
                        )
                        B_stat = (
                            stat_data.find(class_="player2")
                            .find("span")
                            .getText()
                            .strip()
                        )
                    A_stat = A_stat.split()[0] if " " in A_stat else A_stat
                    B_stat = B_stat.split()[0] if " " in B_stat else B_stat
                    A_stat = A_stat.replace("/", "_")
                    B_stat = B_stat.replace("/", "_")
                    match[f"A_{stat_name}"] = A_stat
                    match[f"B_{stat_name}"] = B_stat
            else:
                raise Exception("Unknown error")

            tourney_read = True

        except Exception as e:
            error_count += 1
            print(f"{match['match_id']} stats not found, attempt {error_count}")
            if error_count >= 2:
                tourney_read = True
                print(f"{match['match_id']} stats not found after four attempts")


def get_atp_match_data(driver, tourney):
    tourney_read = False
    error_count = 0
    while not tourney_read:
        match_list = []
        try:
            driver.get(f"https://www.atptour.com/{tourney['tourney_link']}")
            try:
                # Check if results exist, if not, error
                e = WebDriverWait(driver, 1.5).until(
                    EC.presence_of_element_located(
                        (By.XPATH, '//*[@id="scoresResultsContent"]/div')
                    )
                )
            except Exception as e:
                try:
                    # Check if no results exist, if not, error
                    print("Results not found")
                    e = WebDriverWait(driver, 0.5).until(
                        EC.presence_of_element_located((By.CLASS_NAME, "wrapper-404"))
                    )
                    tourney_read = True
                    print("No games")
                    return match_list
                except Exception as e:
                    error_count += 1
                    print("Error count: ", error_count)
                    if error_count > 2:
                        return match_list
                    # If results exist == False and no results exist == False, there must be an error, try again
                    continue

            tourney_match_data = BS(driver.page_source, features="html.parser")
            match_list_table = tourney_match_data.find(class_="day-table")
            match_list_data = match_list_table.children
            round = ""
            for match in match_list_data:
                if match.name == "thead":
                    round_data = match.find("th").getText()
                    round = get_round_string(round_data)
                elif match.name == "tbody":
                    if round == "":
                        continue
                    matches = match.find_all("tr")
                    for m in matches:
                        match_data = {}
                        if not m.find(class_="day-table-score").find("a"):
                            continue
                        match_number_data = m.find(class_="day-table-score").find("a")
                        match_score_text = match_number_data.getText()
                        match_data["score"] = match_score_text
                        if "(W/O)" in match_score_text or "(RET)" in match_score_text:
                            continue
                        if not m.find(class_="day-table-score").find(
                            class_="not-in-system"
                        ):
                            match_link = match_number_data["href"]
                            match_data["match_link"] = match_link
                        elif tourney["tourney_id"] == "20230308_0404" and m.find(
                            class_="day-table-score"
                        ).find(class_="not-in-system"):
                            continue
                        match_data["tourney_name"] = (
                            tourney["tourney_name"].replace("-", " ").title()
                        )
                        match_data["surface"] = tourney["tourney_surface"]
                        match_data["round"] = round
                        match_data["tourney_level"] = tourney["tourney_level"]
                        match_data["tourney_location"] = tourney["tourney_location"]
                        match_data["tourney_IOC"] = tourney["tourney_IOC"]
                        name_data = m.find_all(class_="day-table-name")
                        A_name = name_data[0].find("a").getText().title()
                        B_name = name_data[1].find("a").getText().title()
                        try:
                            match_data["A_atp_id"] = (
                                name_data[0].find("a")["href"].split("/")[4]
                            )
                            match_data["A_atp_id"] = (
                                name_data[1].find("a")["href"].split("/")[4]
                            )
                        except:
                            print(f"ATP ID not found for {A_name} or {B_name}")
                        match_data["A_name"] = A_name
                        match_data["B_name"] = B_name
                        match_list.append(match_data)
            tourney_read = True

        except Exception as e:
            print(e)
            error_count += 1
            print(".Error count: ", error_count)
            if error_count > 2:
                return match_list
            pass

    match_list = fill_match_numbers(match_list, tourney)

    for match in match_list:
        match["A_serve_rating"] = match["A_aces"] = match["A_double_faults"] = match[
            "A_1st_serve"
        ] = match["A_1st_serve_points_won"] = match["A_2nd_serve_points_won"] = match[
            "A_break_points_saved"
        ] = match[
            "A_service_games_played"
        ] = ""
        match["B_serve_rating"] = match["B_aces"] = match["B_double_faults"] = match[
            "B_1st_serve"
        ] = match["B_1st_serve_points_won"] = match["B_2nd_serve_points_won"] = match[
            "B_break_points_saved"
        ] = match[
            "B_service_games_played"
        ] = ""
        match["A_return_rating"] = match["A_1st_serve_return_points_won"] = match[
            "A_2nd_serve_return_points_won"
        ] = match["A_break_points_converted"] = match["A_return_games_played"] = match[
            "A_service_points_won"
        ] = match[
            "A_return_points_won"
        ] = match[
            "A_total_points_won"
        ] = ""
        match["B_return_rating"] = match["B_1st_serve_return_points_won"] = match[
            "B_2nd_serve_return_points_won"
        ] = match["B_break_points_converted"] = match["B_return_games_played"] = match[
            "B_service_points_won"
        ] = match[
            "B_return_points_won"
        ] = match[
            "B_total_points_won"
        ] = ""
        if "match_link" in match:
            get_match_stats(driver, match)

    df = pd.DataFrame(match_list)

    return match_list


def get_itf_match_data(driver, tourney):
    tourney_read = False
    error_count = 0
    while not tourney_read and error_count < 3:
        match_list = []
        try:
            driver.get(tourney["tourney_link"])
            try:
                WebDriverWait(driver, 3).until(
                    EC.element_to_be_clickable(
                        (By.XPATH, '//*[@id="onetrust-accept-btn-handler"]')
                    )
                ).click()
            except:
                pass

            content = driver.page_source
            soup = BS(content, features="html.parser")

            tourney_country = soup.find_all(class_="tournament-hero__value")[
                1
            ].getText()
            tourney["tourney_IOC"] = get_ioc_code(tourney_country)

            getting_matches = True
            while getting_matches:
                sleep(2)
                content = driver.page_source
                soup = BS(content, features="html.parser")
                try:
                    next_button = WebDriverWait(driver, 5).until(
                        EC.element_to_be_clickable(
                            (
                                By.CLASS_NAME,
                                "btn--chevron-next",
                            )
                        )
                    )
                except:
                    next_button = None

                if next_button is not None:
                    match_list_data = soup.find(class_="drawsheet-round-container")
                    get_itf_round_data(match_list, match_list_data, tourney)

                    # Use JavaScript to click the button
                    driver.execute_script("arguments[0].click();", next_button)
                else:
                    match_list_data = soup.find_all(class_="drawsheet-round-container")
                    for match_list_data_inner in match_list_data:
                        get_itf_round_data(match_list, match_list_data_inner, tourney)
                    getting_matches = False
            tourney_read = True
        except Exception as e:
            exc_type, exc_value, exc_traceback = sys.exc_info()
            traceback_details = traceback.extract_tb(exc_traceback)

            filename = traceback_details[-1].filename
            line_no = traceback_details[-1].lineno
            func = traceback_details[-1].name

            print(
                "Error getting ITF match data.",
                f"Exception occurred in file {filename}, line {line_no}, in {func}: {e}",
            )
            error_count += 1

    mapping = {
        "1st Round": "R32",
        "2nd Round": "R16",
        "Quarter-finals": "QF",
        "Semi-finals": "SF",
        "Final": "F",
    }

    if any(m["round"] == "4th Round" for m in match_list):
        mapping.update(
            {
                "1st Round": "R128",
                "2nd Round": "R64",
                "3rd Round": "R32",
                "4th Round": "R16",
            }
        )
    elif any(m["round"] == "3rd Round" for m in match_list):
        mapping.update({"1st Round": "R64", "2nd Round": "R32", "3rd Round": "R16"})

    for m in match_list:
        round_value = m["round"]
        if round_value in mapping:
            m["round"] = mapping[round_value]

    match_list = fill_match_numbers(match_list, tourney)

    return match_list


def get_itf_round_data(match_list, match_list_container, tourney):
    round_text = match_list_container.find(
        class_="drawsheet-round-container__round-title"
    ).getText()
    round = get_round_string(round_text)
    inner_match_list = match_list_container.find_all(class_="drawsheet-widget__inner")
    for match in inner_match_list:
        match_data = {}
        match_data["A_name"] = ""
        match_data["B_name"] = ""

        match_data["score"] = match.find(class_="drawsheet-widget__score").getText()
        if match_data["score"] == "":
            continue

        winner = (
            match.find(class_="is-winner")
            .find(class_="drawsheet-widget__first-name")
            .getText()
            + " "
            + match.find(class_="is-winner")
            .find(class_="drawsheet-widget__last-name")
            .getText()
        )
        for player in match.find_all(class_="player-wrapper"):
            player_name = (
                player.find(class_="drawsheet-widget__first-name").getText()
                + " "
                + player.find(class_="drawsheet-widget__last-name").getText()
            )
            if player_name == winner:
                match_data["A_name"] = player_name.title()
            else:
                match_data["B_name"] = player_name.title()
            try:
                match_data["A_itf_id"] = player.find("a")["href"].split("/")[4]
            except:
                print(f"ITF ID not found for {player_name.title()}")
            match_data["tourney_name"] = tourney["tourney_name"]
            match_data["surface"] = tourney["tourney_surface"]
            match_data["round"] = round
            match_data["tourney_level"] = tourney["tourney_level"]
            match_data["tourney_location"] = tourney["tourney_location"]
            match_data["tourney_IOC"] = tourney["tourney_IOC"]
        match_list.append(match_data)


def get_itf_year_data(driver, year, update=False, start_date="", end_date=""):
    if start_date == "":
        start_date = f"01/01/{str(year)}"
    start_date = datetime.strptime(start_date, "%d/%m/%Y")
    if end_date == "":
        end_date = f"31/12/{str(year)}"
    end_date = datetime.strptime(end_date, "%d/%m/%Y")

    url = f"https://www.itftennis.com/en/tournament-calendar/mens-world-tennis-tour-calendar/?categories=All&startdate={str(year)}"

    itf_year_loaded = False
    error_count = 0
    while itf_year_loaded == False:
        try:
            driver.get(url)
            WebDriverWait(driver, 10).until(
                EC.presence_of_element_located(
                    (By.CLASS_NAME, "whatson-table__tournament")
                )
            )
            itf_year_loaded = True
        except:
            print("Loading ITF year failed, trying again...")
            error_count += 1
            if error_count > 2:
                return []
            pass

    try:
        accept_cookies = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.ID, "onetrust-accept-btn-handler"))
        )
        driver.execute_script("arguments[0].click()", accept_cookies)
        sleep(2)
    except:
        pass

    more_matches = True
    while more_matches:
        try:
            more_matches_button = WebDriverWait(driver, 2).until(
                EC.element_to_be_clickable(
                    (By.XPATH, '//*[@id="whatson-hero"]/div[3]/section/div/div/button')
                )
            )
            driver.execute_script("arguments[0].click()", more_matches_button)
            print("More matches...")
            sleep(2.5)
        except Exception as e:
            more_matches = False

    content = driver.page_source
    soup = BS(content, features="html.parser")

    tourney_list_data = soup.find_all(class_="whatson-table__tournament")
    tourney_list = []

    for tourney in tourney_list_data:
        tourney_date_string = (
            tourney.find_all("td")[1].find(class_="date").getText().split(" to ")[1]
        )
        tourney_datetime = datetime.strptime(
            tourney_date_string, "%d %b %Y"
        ) - timedelta(days=6)
        tourney_date = datetime.strftime(tourney_datetime, "%Y%m%d")
        if update == True:
            if tourney_datetime < datetime.now() - timedelta(days=10):
                continue
        else:
            if tourney_datetime < start_date or tourney_datetime > end_date:
                continue
        if tourney_datetime > datetime.now() + timedelta(days=2):
            continue
        tourney_name = tourney.find(class_="short").getText()
        if year > 2018:
            tourney_name = tourney_name.replace(
                f"{tourney_name.split(' ')[0]} ", ""
            ).title()
        else:
            tourney_name = (
                tourney_name.lower()
                .replace(
                    f" {tourney_name.lower().split(' ')[len(tourney_name.split(' '))-2]} futures",
                    "",
                )
                .title()
            )
        tourney_number = tourney.find("a")["href"].split("/")[6].split("-")[2]
        tourney_number = (
            tourney_number + tourney.find("a")["href"].split("/")[6].split("-")[3]
        )
        tourney_level = "F"
        tourney_surface = (
            tourney.find(class_="surface")
            .find(class_="surface")
            .getText()
            .split(" - ")[1]
        )
        tourney_location = tourney_name
        if ", " in tourney_location:
            tourney_location = tourney_location.split(", ")[0]
        tourney_IOC = ""
        tourney_id = f"{tourney_date}_{str(tourney_number).zfill(4)}"
        tourney_link = (
            "https://www.itftennis.com/"
            + tourney.find("a")["href"]
            + "draws-and-results/"
        )
        tourney_list.append(
            {
                "tourney_id": tourney_id,
                "tourney_name": tourney_name,
                "tourney_date": tourney_date,
                "tourney_number": tourney_number,
                "tourney_level": tourney_level,
                "tourney_location": tourney_location,
                "tourney_IOC": tourney_IOC,
                "tourney_surface": tourney_surface,
                "tourney_link": tourney_link,
            }
        )

    print("Returning year data")
    return tourney_list


def get_year_data(
    driver,
    year,
    update=False,
    start_date="",
    end_date="",
    level="ATP",
):
    if start_date == "":
        start_date = f"01/01/{str(year)}"
    start_date = datetime.strptime(start_date, "%d/%m/%Y")
    if end_date == "":
        end_date = f"31/12/{str(year)}"
    end_date = datetime.strptime(end_date, "%d/%m/%Y")
    level_suffix = ""
    if level == "Challenger":
        level_suffix = "&tournamentType=ch"

    url = f"https://www.atptour.com/en/scores/results-archive?year={str(year) + level_suffix}"
    driver.get(url)

    content = driver.page_source

    soup = BS(content, features="html.parser")

    tourney_list_data = soup.find_all(class_="tourney-result")
    tourney_list = []

    for tourney in tourney_list_data:
        tourney_date = datetime.strptime(
            tourney.find(class_="tourney-dates").getText().strip(), "%Y.%m.%d"
        )
        if update == True:
            if tourney_date < datetime.now() - timedelta(days=10):
                continue
        else:
            if tourney_date < start_date or tourney_date > end_date:
                continue
        if tourney_date > datetime.now() + timedelta(days=4):
            continue
        try:
            tourney_name_href = tourney.find(class_="title-content").find("a")["href"]
        except Exception as e:
            print("Tournament links not found", e)
            continue
        tourney_link_href = ""
        try:
            tourney_link_href = tourney.find_all(class_="tourney-details")[4].find("a")[
                "href"
            ]
        except:
            pass
        split_href = tourney_name_href.split("/")
        tourney_name = split_href[3]
        tourney_number = split_href[4]
        tourney_level_string = ""
        if tourney.find(class_="tourney-badge-wrapper").find("img"):
            tourney_level_data = tourney.find(class_="tourney-badge-wrapper").find(
                "img"
            )["src"]
            tourney_level_string = tourney_level_data.split("/")[6][15:-4]
        tourney_level = ""
        if tourney_level_string == "grandslam":
            tourney_level = "G"
        elif tourney_level_string == "1000":
            tourney_level = "M"
        elif tourney_level_string == "challenger":
            tourney_level = "C"
        else:
            tourney_level = "A"
        tourney_surface = (
            tourney.find_all(class_="tourney-details")[1]
            .find(class_="item-value")
            .getText()
            .strip()
        )
        tourney_link = tourney_link_href.replace("live-scores", "results")
        if tourney_date > datetime.now() + timedelta(days=7):
            continue
        tourney_location = tourney.find(class_="tourney-location").getText().strip()
        tourney_IOC = get_ioc_code(tourney_location)
        tourney_date = tourney_date.strftime("%Y%m%d")
        tourney_id = f"{tourney_date}_{str(tourney_number).zfill(4)}"
        if level == "Challenger":
            tourney_id = tourney_id + "C"
        tourney_list.append(
            {
                "tourney_id": tourney_id,
                "tourney_name": tourney_name,
                "tourney_date": tourney_date,
                "tourney_number": tourney_number,
                "tourney_level": tourney_level,
                "tourney_location": tourney_location,
                "tourney_IOC": tourney_IOC,
                "tourney_surface": tourney_surface,
                "tourney_link": tourney_link,
            }
        )
        print(
            tourney_id,
            tourney_name,
            tourney_level,
            tourney_location,
            tourney_IOC,
            tourney_surface,
        )

    print("Returning year data")
    return tourney_list


def get_atp_fixture_data(driver, tourney):
    fixture_list = []
    page_loaded = False
    error_count = 0
    while not page_loaded and error_count < 3:
        try:
            driver.get(
                f"https://www.atptour.com/en/scores/current/{tourney['tourney_name']}/{tourney['tourney_number']}/daily-schedule"
            )
            sleep(1.5)
            WebDriverWait(driver, 3).until(
                EC.presence_of_element_located((By.CLASS_NAME, "dropdown-holder"))
            )
            page_loaded = True
        except:
            error_count += 1
            sleep(1.5)

    if (
        page_loaded == False
        or not driver.current_url.split("/")[-1] == "daily-schedule"
    ):
        print("No fixture data found for", tourney["tourney_id"])
        return fixture_list

    page_source = BS(driver.page_source, features="html.parser")

    dropdown_holder = page_source.find(class_="dropdown-holder")
    options = dropdown_holder.find_all("li")

    # Get list of highest 3 data values from options
    data_values = []
    for option in options:
        data_values.append(int(option["data-value"]))
    max_data_values = sorted(data_values, reverse=True)[:3]

    for value in max_data_values:
        page_loaded = False
        error_count = 0
        while not page_loaded and error_count < 3:
            try:
                driver.get(
                    f"https://www.atptour.com/en/scores/current/{tourney['tourney_name']}/{tourney['tourney_number']}/daily-schedule?day={str(value)}"
                )
                sleep(1.5)
                WebDriverWait(driver, 12).until(
                    EC.presence_of_element_located(
                        (By.CLASS_NAME, "sectioned-day-tables")
                    )
                )
                page_loaded = True
            except:
                error_count += 1
                sleep(1.5)

        if page_loaded == False:
            print("No fixture data found for", tourney["tourney_id"])
            return fixture_list

        fixture_data = BS(driver.page_source, features="html.parser")
        fixture_list_table = fixture_data.find(class_="sectioned-day-tables")

        round = ""
        for tbody in fixture_list_table.find_all("tbody"):
            matches = tbody.find_all("tr")
            for m in matches:
                try:
                    if not m.find(class_="day-table-name"):
                        continue
                    if m.find("span", class_="tour-association-wta"):
                        continue
                    if len(m.find(class_="day-table-name").find_all("a")) > 1:
                        continue
                    if m.find(class_="day-table-score").getText().strip() != "-":
                        continue
                except:
                    continue
                fixture = {}
                round = m.find(class_="day-table-round").getText().strip()
                fixture["round"] = round
                name_data = m.find_all(class_="day-table-name")
                A_name = name_data[0].find("a").getText().title()
                B_name = name_data[1].find("a").getText().title()
                fixture["A_name"] = A_name
                fixture["B_name"] = B_name
                fixture["tourney_surface"] = tourney["tourney_surface"]
                fixture["tourney_level"] = tourney["tourney_level"]
                fixture["round"] = tourney["round"]
                fixture["tourney_name"] = tourney["tourney_name"]
                fixture["tourney_IOC"] = tourney["tourney_IOC"]
                fixture_list.append(fixture)

    fixture_list = fill_match_numbers(fixture_list, tourney)

    print(
        "Returning fixture data for", tourney["tourney_name"], tourney["tourney_date"]
    )

    return fixture_list


def worker_thread(task_queue, position_queue, db_file, overwrite=True):
    global database_lock
    if platform.system() == "Windows":
        DRIVER_PATH = "chromedriver.exe"
    elif platform.system() == "Darwin":  # This is the value returned for macOS
        DRIVER_PATH = "chromedriver"
    driver = uc.Chrome(driver_executable_path=DRIVER_PATH)

    window_position = position_queue.get()
    driver.set_window_size(window_position["width"], window_position["height"])
    driver.set_window_position(window_position["x"], window_position["y"])

    total_fixtures = []
    total_matches = []

    conn = sqlite3.connect(db_file)
    c = conn.cursor()

    while not task_queue.empty() and not stop_threads:
        task = task_queue.get()
        tourney = task[1]

        tourney_id = tourney["tourney_id"]

        tourney_name_string = tourney["tourney_name"]
        tourney_level_string = tourney["tourney_level"]
        tourney_id_string = tourney["tourney_id"]
        tourney_ioc_string = tourney["tourney_IOC"]

        print(
            f"Name: {tourney_name_string}. Level: {tourney_level_string}. ID: {tourney_id_string}. IOC: {tourney_ioc_string}"
        )

        matches_found = None
        if not overwrite:
            c.execute(
                "SELECT COUNT(*) FROM tennis_matches WHERE match_id LIKE ?",
                (f"{tourney_id}%",),
            )
            matches_found = c.fetchone()[0]
        else:
            c.execute(
                "SELECT COUNT(*) FROM tennis_matches WHERE (match_id LIKE ? AND round = 'F')",
                (f"{tourney_id}%",),
            )
            print("Final found in tournament:", tourney_id)
            matches_found = c.fetchone()[0]

        fixture_list = []
        match_list = []

        tourney_datetime = datetime.strptime(tourney["tourney_date"], "%Y%m%d")
        if tourney_datetime > datetime.now() - timedelta(days=10) and tourney[
            "tourney_level"
        ] in ["A", "M", "G"]:
            fixture_list = get_atp_fixture_data(driver, tourney)

        if matches_found == 1:
            print(f"Skipping {tourney_id} as it already exists in the database.")
        else:
            if tourney["tourney_level"] == "F":
                match_list = get_itf_match_data(driver, tourney)
            else:
                match_list = get_atp_match_data(driver, tourney)

        total_fixtures.extend(fixture_list)
        total_matches.extend(match_list)

        task_queue.task_done()
        position_queue.put(window_position)

    driver.quit()

    while database_lock:
        sleep(3)

    database_lock = True
    write_to_db(c, conn, total_matches)
    write_to_pd(total_fixtures)
    database_lock = False


def scrape_data_to_sqlite(
    start_year,
    end_year,
    start_date="",
    end_date="",
    included_levels=["ITF", "Chall", "ATP"],
    update=False,
    overwrite=False,
):
    global stop_threads
    db_file = "data/matches.sqlite"

    # Create an empty SQLite database if it doesn't exist
    if not os.path.exists(db_file):
        with sqlite3.connect(db_file) as conn:
            c = conn.cursor()
            c.execute(
                """
            CREATE TABLE tennis_matches (
                match_id TEXT PRIMARY KEY, tourney_name TEXT, surface TEXT, round TEXT,
                tourney_level TEXT, tourney_IOC TEXT, tourney_location TEXT, A_name TEXT, B_name TEXT, A_serve_rating REAL,
                A_aces INTEGER, A_double_faults INTEGER, A_1st_serve REAL, A_1st_serve_points_won REAL,
                A_2nd_serve_points_won REAL, A_break_points_saved REAL, A_service_games_played INTEGER,
                B_serve_rating REAL, B_aces INTEGER, B_double_faults INTEGER, B_1st_serve REAL,
                B_1st_serve_points_won REAL, B_2nd_serve_points_won REAL, B_break_points_saved REAL,
                B_service_games_played INTEGER, A_return_rating REAL, A_1st_serve_return_points_won REAL,
                A_2nd_serve_return_points_won REAL, A_break_points_converted REAL, A_return_games_played INTEGER,
                A_service_points_won REAL, A_return_points_won REAL, A_total_points_won REAL,
                B_return_rating REAL, B_1st_serve_return_points_won REAL, B_2nd_serve_return_points_won REAL,
                B_break_points_converted REAL, B_return_games_played INTEGER, B_service_points_won REAL,
                B_return_points_won REAL, B_total_points_won REAL, match_link TEXT
            );
            """
            )

    if platform.system() == "Windows":
        DRIVER_PATH = "chromedriver.exe"
    elif platform.system() == "Darwin":  # This is the value returned for macOS
        DRIVER_PATH = "chromedriver"

    # Calculate window positions
    screen_width, screen_height = get_monitors()[0].width, get_monitors()[0].height
    quarter_width = screen_width // 2
    quarter_height = screen_height // 2
    window_positions = [
        {"x": 0, "y": 0, "width": quarter_width, "height": quarter_height},
        {"x": 0, "y": quarter_height, "width": quarter_width, "height": quarter_height},
        {"x": quarter_width, "y": 0, "width": quarter_width, "height": quarter_height},
        {
            "x": quarter_width,
            "y": quarter_height,
            "width": quarter_width,
            "height": quarter_height,
        },
    ]

    tasks = queue.PriorityQueue()
    for year in range(start_year, end_year + 1):
        for tennis_level in included_levels:
            driver = uc.Chrome(
                driver_executable_path=DRIVER_PATH,
            )
            if tennis_level == "ITF":
                tourney_list = get_itf_year_data(
                    driver,
                    year,
                    update=update,
                    start_date=start_date,
                    end_date=end_date,
                )
            elif tennis_level == "Chall":
                tourney_list = get_year_data(
                    driver,
                    year,
                    update=update,
                    start_date=start_date,
                    end_date=end_date,
                    level="Challenger",
                )
            elif tennis_level == "ATP":
                tourney_list = get_year_data(
                    driver,
                    year,
                    update=update,
                    start_date=start_date,
                    end_date=end_date,
                )
            for tourney in tourney_list:
                tasks.put((tourney["tourney_id"], tourney))
            print("Length of Tournament List:", len(tourney_list))
            print("Tasks in queue:", tasks.qsize())
            driver.quit()

    # Create a separate queue for window positions
    position_queue = queue.Queue()
    for position in window_positions:
        position_queue.put(position)

    threads = []
    num_threads = 4
    for _ in range(num_threads):
        t = threading.Thread(
            target=worker_thread, args=(tasks, position_queue, db_file, overwrite)
        )
        t.start()
        threads.append(t)

    try:
        for t in threads:
            t.join()
    except KeyboardInterrupt:
        print("\nInterrupted. Stopping threads...")
        stop_threads = True
        for t in threads:
            t.join()
        print("Threads stopped. Exiting.")


if __name__ == "__main__":
    scrape_data_to_sqlite(2023, 2023)
