from bs4 import BeautifulSoup as BS
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException
import undetected_chromedriver as uc
import sqlite3
import sys
import traceback
import logging
from alive_progress import alive_bar
import csv

# Configure logging
logging.basicConfig(filename="scraping_logs.log", level=logging.ERROR)
logger = logging.getLogger(__name__)


def main(update=True, included_levels=["G", "M", "A"]):
    db_file = "data/matches.sqlite"
    conn = sqlite3.connect(db_file)
    c = conn.cursor()

    # Create player_data table if it doesn't exist
    c.execute(
        "CREATE TABLE IF NOT EXISTS player_data (player TEXT PRIMARY KEY, IOC TEXT, DOB TEXT, isActive INTEGER)"
    )
    conn.commit()
    print("Player data table created/exists")

    # Fetch existing player data
    c.execute("SELECT player, IOC, DOB, isActive FROM player_data")
    current_player_data = {
        row[0]: {"player": row[0], "IOC": row[1], "DOB": row[2], "isActive": row[3]}
        for row in c.fetchall()
    }

    # Get all unique names from A_name and B_name columns in matches table
    c.execute(
        f'SELECT DISTINCT A_name FROM tennis_matches WHERE match_id > "2010" AND tourney_level IN ({",".join(["?"] * len(included_levels))})',
        included_levels,
    )
    A_names = c.fetchall()
    c.execute(
        f'SELECT DISTINCT B_name FROM tennis_matches WHERE match_id > "2010" AND tourney_level IN ({",".join(["?"] * len(included_levels))})',
        included_levels,
    )
    B_names = c.fetchall()
    players = list(set([name[0] for name in A_names + B_names]))
    print("Players fetched")

    # Initialize Chrome driver
    driver = uc.Chrome(headless=True)

    player_data = {}
    # Iterate through all players and scrape or update data
    print("Scraping player data")
    num_players = len(players)
    try:
        with alive_bar(num_players) as bar:
            for player in players:
                action = ""
                if player in current_player_data and update == True:
                    player_info = current_player_data[player]
                    if (
                        player_info["IOC"] == ""
                        or player_info["DOB"] == ""
                        or player_info["isActive"] == None
                    ):
                        player_data[player] = scrape_player_data(driver, player)
                        action = "Updated"
                    else:
                        player_data[player] = player_info
                        action = "Found"
                else:
                    player_data[player] = scrape_player_data(driver, player)

                    # Check if scraped data has more info than current data
                    if player in current_player_data:
                        current_player_info = current_player_data[player]
                        if (
                            player_data[player]["IOC"] == ""
                            and current_player_info["IOC"] != ""
                        ):
                            player_data[player]["IOC"] = current_player_info["IOC"]
                        if (
                            player_data[player]["DOB"] == ""
                            and current_player_info["DOB"] != ""
                        ):
                            player_data[player]["DOB"] = current_player_info["DOB"]
                        if player_data[player]["isActive"] == None and (
                            current_player_info["isActive"] != None
                            or current_player_info["isActive"] == 0
                        ):
                            player_data[player]["isActive"] = current_player_info[
                                "isActive"
                            ]
                    action = "Scraped"
                print(f"{action} data for {player}: {player_data[player]}")
                bar()
    except KeyboardInterrupt:
        print("Keyboard Interrupt detected. Saving data and exiting.")

    driver.quit()
    print("Player data scraped")

    # Update or insert the player data into the database
    print("Updating player data in database")
    save_player_data_to_sqlite(conn, player_data)
    conn.close()  # Close the connection
    print("Player data updated in database")

    # Save the player data to a csv file
    print("Saving player data to csv")
    with open("data/player_data.csv", "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["player", "IOC", "DOB", "isActive"])
        for player, info in player_data.items():
            writer.writerow([player, info["IOC"], info["DOB"], info["isActive"]])

    print("Player data saved to csv")
    print("Done")


def scrape_player_data(driver, player):
    try:
        driver.get("https://www.atptour.com/en/")

        search_control = WebDriverWait(driver, 5).until(
            EC.presence_of_element_located((By.ID, "controlSearch"))
        )

        driver.execute_script("arguments[0].click();", search_control)

        search_bar = WebDriverWait(driver, 5).until(
            EC.presence_of_element_located((By.CLASS_NAME, "search"))
        )

        search_bar.send_keys(player)

        def search_for_player():
            try:
                WebDriverWait(driver, 5).until(
                    EC.presence_of_element_located(
                        (By.CLASS_NAME, "predictive-result-title")
                    )
                )
            except TimeoutException:
                search_bar.clear()
                search_bar.send_keys(player)
                WebDriverWait(driver, 5).until(
                    EC.presence_of_element_located(
                        (By.CLASS_NAME, "predictive-result-title")
                    )
                )

        search_for_player()

        predictive_results = driver.find_elements(
            By.CLASS_NAME, "predictive-result-title"
        )

        for result in predictive_results:
            name_link = result.find_element(By.CSS_SELECTOR, "a")
            if name_link.text.lower() == player.lower():
                name_link.click()
                break

        content = driver.page_source
        soup = BS(content, features="html.parser")

        flag_code = soup.find(class_="player-flag-code")
        birthday = soup.find(class_="table-birthday")

        IOC = flag_code.getText().strip() if flag_code else ""
        DOB = (
            birthday.getText()
            .strip()
            .replace("(", "")
            .replace(")", "")
            .replace(".", "")
            if birthday
            else ""
        )
        isActive = (
            0
            if soup.find(class_="data-label-text").getText().strip() == "Inactive"
            else 1
        )
        return {"IOC": IOC, "DOB": DOB, "isActive": isActive}
    except Exception as e:
        exc_type, exc_value, exc_traceback = sys.exc_info()
        traceback_details = traceback.extract_tb(exc_traceback)

        filename = traceback_details[-1].filename
        line_no = traceback_details[-1].lineno
        func = traceback_details[-1].name

        error_msg = f"Error getting player data for {player}. Exception occurred in file {filename}, line {line_no}, in {func}: {e}"
        logger.error(error_msg)  # Log the error to the file

        print(error_msg)

        return {"IOC": "", "DOB": "", "isActive": None}


def save_player_data_to_sqlite(conn, player_data):
    c = conn.cursor()

    # Get existing player data
    c.execute("SELECT * FROM player_data")
    current_player_data = {row[0]: row for row in c.fetchall()}

    for player, info in player_data.items():
        if player not in current_player_data:
            c.execute(
                "INSERT INTO player_data (player, IOC, DOB, isActive) VALUES (?, ?, ?, ?)",
                (player, info["IOC"], info["DOB"], info["isActive"]),
            )
        else:
            c.execute(
                "UPDATE player_data SET IOC = ?, DOB = ?, isActive = ? WHERE player = ?",
                (info["IOC"], info["DOB"], info["isActive"], player),
            )
    conn.commit()


if __name__ == "__main__":
    main()
