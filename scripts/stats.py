import math
from datetime import datetime, timedelta

import pandas as pd
from dateutil.relativedelta import relativedelta

from config.config import ELO_CONSTANTS
from scripts.data_helpers import simplify_name


def get_quarters_since_played(player_name, match_id, conn):
    player_name_query = player_name.replace("'", "''")
    query = f"SELECT match_id FROM tennis_matches WHERE (A_simplified_name = '{player_name_query}' \
        OR B_simplified_name = '{player_name_query}')"

    if match_id:
        query = query + f" AND match_id < '{match_id}'"

    query = query + " ORDER BY match_id DESC LIMIT 1;"
    matches_df = pd.read_sql_query(query, conn)
    if matches_df.empty:
        return 0

    if match_id:
        current_date = datetime.strptime(match_id[:8], "%Y%m%d")
    else:
        current_date = datetime.now()

    last_match_id = matches_df.iloc[0]["match_id"]
    last_match_date = datetime.strptime(last_match_id[:8], "%Y%m%d")

    delta = relativedelta(current_date, last_match_date)
    months = delta.years * 12 + delta.months
    return math.floor(months / 3)


def get_fatigue_scores(player_name, match_id, matches):
    """
    Calculate the total number of games played by a player within certain time periods.

    Args:
    player_name (str): Name of the player.
    match_id (str): Match ID to stop calculations before this match (exclusive).
    matches (list): A list of dictionaries where each dictionary represents a tennis match.

    Returns:
    list: A list of three integers representing the total number of games played by the player:
          - in the last match (if it was in the same tournament),
          - in the current tournament so far,
          - this year so far.
    """
    # Initialize counts
    last_match_games = 0
    tournament_games = 0
    year_games = 0

    # Extract year, tournament from the current match_id
    current_year = match_id[:4]
    current_tournament = "_".join(match_id.split("_")[:2])

    # Sort matches by match_id in descending order
    matches = sorted(matches, key=lambda k: k["match_id"], reverse=True)

    # Iterate through matches in reverse order (most recent first)
    for match in matches:
        if match["match_id"] < match_id:
            # Check if score is available
            if not match["score"]:
                continue

            # Check if match is finished
            if "_" not in match["score"]:
                continue

            # Calculate games in match, ignoring tiebreak scores
            scores = match["score"].split("_")
            games = sum(int(score[0]) + int(score[1]) for score in scores)

            # Update yearly count
            if match["match_id"].startswith(current_year) and (
                match["A_simplified_name"] == player_name
                or match["B_simplified_name"] == player_name
            ):
                year_games += games

            # Check if the match is in the current tournament
            if "_".join(match["match_id"].split("_")[:2]) == current_tournament and (
                match["A_simplified_name"] == player_name
                or match["B_simplified_name"] == player_name
            ):
                # Update tournament count
                tournament_games += games

                # If this is the first match we've encountered from the current tournament, it's the "last match"
                if last_match_games == 0:
                    last_match_games = games

    return [last_match_games, tournament_games, year_games]


def get_h2h(player_names, match_id, matches, conditions_list):
    """
    Get the head-to-head record between two players based on different conditions.

    Args:
    player_names (list): List of two players' names [player_A_simplified_name, player_B_simplified_name]
    match_id (str): Match ID to stop calculations before this match (exclusive).
    matches (list): A list of dictionaries where each dictionary represents a tennis match.
    conditions_list (list): A list of dictionaries where each dictionary represents a condition.
                            Possible keys in the dictionary include:
                            - weeks: Number of weeks before the match_id.
                            - surface: Surface type (e.g. 'grass', 'clay', 'hard').
                            - IOC: International Olympic Committee country code.
                            - tourney_name: Name of the tournament.
                            - round: Round of the match (e.g. 'F', 'SF', 'QF', 'R32').

    Returns:
    list: A list of head-to-head records for each condition provided in the conditions_list.
          The order of the records in the list corresponds to the order of conditions in the conditions_list.
    """
    results = []
    for condition in conditions_list:
        weeks = condition.get("weeks")
        surface = condition.get("surface")
        IOC = condition.get("IOC")
        tourney_name = condition.get("tourney_name")
        round_ = condition.get("round")
        tourney_level = condition.get("tourney_level")

        filtered_matches = matches.copy()

        if weeks is not None:
            if match_id:
                date_obj = datetime.strptime(match_id[:8], "%Y%m%d")
            else:
                date_obj = datetime.now()
            prior_date_obj = date_obj - timedelta(days=weeks * 7)
            prior_date_string = prior_date_obj.strftime("%Y%m%d")
            filtered_matches = [
                match
                for match in filtered_matches
                if match["match_id"] > prior_date_string
                and match["match_id"] < match_id
            ]

        if surface is not None:
            filtered_matches = [
                match for match in filtered_matches if match["surface"] == surface
            ]

        if IOC is not None:
            filtered_matches = [
                match for match in filtered_matches if match["tourney_IOC"] == IOC
            ]

        if tourney_name is not None:
            filtered_matches = [
                match
                for match in filtered_matches
                if simplify_name(match["tourney_name"]) == simplify_name(tourney_name)
            ]

        if round_ is not None:
            filtered_matches = [
                match for match in filtered_matches if match["round"] == round_
            ]

        if tourney_level is not None:
            filtered_matches = [
                match
                for match in filtered_matches
                if match["tourney_level"] == tourney_level
            ]

        player_A_h2h = 0
        player_B_h2h = 0
        for match in filtered_matches:
            if (
                match["A_simplified_name"] == player_names[0]
                and match["B_simplified_name"] == player_names[1]
            ):
                player_A_h2h += 1
            elif (
                match["A_simplified_name"] == player_names[1]
                and match["B_simplified_name"] == player_names[0]
            ):
                player_B_h2h += 1

        results.append([player_A_h2h, player_B_h2h])

    return results


def get_previous_elo(player_name, match_id, matches):
    # Sort matches by match_id, with the most recent match first
    matches = sorted(matches, key=lambda k: k["match_id"], reverse=True)

    # Iterate through the matches in reverse order and find the first one with a match_id less than the given match_id
    for match in matches:
        if match["match_id"] < match_id:
            # Get the player's previous elo value
            if match["A_simplified_name"] == player_name:
                return match["A_elo"]
            else:
                return match["B_elo"]

    # No previous matches found for the player
    return 1500


def get_all_matches_for_player(player_name, conn):
    cursor = conn.cursor()

    # Get all the matches for the specified player
    cursor.execute(
        """
        SELECT 
            *
        FROM 
            tennis_matches
        WHERE 
            A_simplified_name = ? OR B_simplified_name = ?
        ORDER BY
            match_id
    """,
        (player_name, player_name),
    )

    columns = [column[0] for column in cursor.description]
    rows = cursor.fetchall()

    # Create a list of dictionaries with match information
    matches = [dict(zip(columns, row)) for row in rows]

    return matches


def get_win_loss_record(
    player_name, match_id, matches, conditions_list, serve_rating_margin=None
):
    """
    Get win-loss records for a tennis player based on different conditions.

    Args:
    player_name (str): Name of the player.
    match_id (str): Match ID to stop calculations before this match (exclusive).
    matches (list): A list of dictionaries where each dictionary represents a tennis match.
                    The dictionary should contain the following keys:
                    - match_id (str): Unique identifier for the match.
                    - A_simplified_name (str): Name of player A.
                    - A_elo (int): Elo rating for player A.
                    - B_simplified_name (str): Name of player B.
                    - B_elo (int): Elo rating for player B.
                    - tourney_name (str): Name of the tournament.
                    - tourney_IOC (str): International Olympic Committee country code for the tournament.
                    - surface (str): Surface type (e.g. 'grass', 'clay', 'hard').
                    - round (str): Round of the match (e.g. 'F', 'SF', 'QF', 'R32').
                    - winner_name (str): Name of the winner.
    conditions_list (list): A list of dictionaries where each dictionary represents a condition.
                            Possible keys in the dictionary include:
                            - weeks: Number of weeks before the match_id.
                            - surface: Surface type (e.g. 'grass', 'clay', 'hard').
                            - IOC: International Olympic Committee country code.
                            - tourney_name: Name of the tournament.
                            - round: Round of the match (e.g. 'F', 'SF', 'QF', 'R32').

    Returns:
    list: A list of tuples (wins, losses) for each condition provided in the conditions_list.
          The order of the tuples in the list corresponds to the order of conditions in the conditions_list.
    """

    results = []
    for condition in conditions_list:
        weeks = condition.get("weeks")
        surface = condition.get("surface")
        IOC = condition.get("IOC")
        tourney_name = condition.get("tourney_name")
        round_ = condition.get("round")
        tourney_level = condition.get("tourney_level")

        filtered_matches = matches.copy()

        if weeks is not None:
            if match_id:
                date_obj = datetime.strptime(match_id[:8], "%Y%m%d")
            else:
                date_obj = datetime.now()
            prior_date_obj = date_obj - timedelta(days=weeks * 7)
            prior_date_string = prior_date_obj.strftime("%Y%m%d")
            filtered_matches = [
                match
                for match in filtered_matches
                if match["match_id"] > prior_date_string
                and match["match_id"] < match_id
            ]

        if surface is not None:
            filtered_matches = [
                match for match in filtered_matches if match["surface"] == surface
            ]

        if IOC is not None:
            filtered_matches = [
                match for match in filtered_matches if match["tourney_IOC"] == IOC
            ]

        if tourney_name is not None:
            filtered_matches = [
                match
                for match in filtered_matches
                if simplify_name(match["tourney_name"]) == simplify_name(tourney_name)
            ]

        if round_ is not None:
            filtered_matches = [
                match for match in filtered_matches if match["round"] == round_
            ]

        if tourney_level is not None:
            filtered_matches = [
                match
                for match in filtered_matches
                if match["tourney_level"] == tourney_level
            ]

        if serve_rating_margin is not None:
            serve_rating, margin = serve_rating_margin
            filtered_matches = [
                match
                for match in filtered_matches
                if (
                    serve_rating - margin
                    <= match["A_avg_serve_rating"]
                    <= serve_rating + margin
                    and player_name == match["A_simplified_name"]
                )
                or (
                    serve_rating - margin
                    <= match["B_avg_serve_rating"]
                    <= serve_rating + margin
                    and player_name == match["B_simplified_name"]
                )
            ]

        wins = len(
            [
                match
                for match in filtered_matches
                if match["A_simplified_name"] == player_name
            ]
        )
        losses = len(
            [
                match
                for match in filtered_matches
                if match["A_simplified_name"] != player_name
            ]
        )
        results.append((wins, losses))

    return results


def get_elo_performance(
    player_name, match_id, matches, conditions_list, serve_rating_margin=None
):
    """
    Calculate the Elo performance rating for a tennis player based on different conditions.

    Args:
    player_name (str): Name of the player.
    match_id (str): Match ID to stop calculations before this match (exclusive).
    matches (list): A list of dictionaries where each dictionary represents a tennis match.
                    The dictionary should contain the following keys:
                    - match_id (str): Unique identifier for the match.
                    - A_simplified_name (str): Name of player A.
                    - A_elo (int): Elo rating for player A.
                    - B_simplified_name (str): Name of player B.
                    - B_elo (int): Elo rating for player B.
                    - tourney_name (str): Name of the tournament.
                    - tourney_IOC (str): International Olympic Committee country code for the tournament.
                    - tourney_level (str): Level of the tournament (e.g. 'G', 'M', 'F').
                    - surface (str): Surface type (e.g. 'grass', 'clay', 'hard').
                    - round (str): Round of the match (e.g. 'F', 'SF', 'QF', 'R32').
                    - winner_name (str): Name of the winner.
    conditions_list (list): A list of dictionaries where each dictionary represents a condition.
                            Possible keys in the dictionary include:
                            - weeks: Number of weeks before the match_id.
                            - surface: Surface type (e.g. 'grass', 'clay', 'hard').
                            - IOC: International Olympic Committee country code.
                            - tourney_name: Name of the tournament.
                            - round: Round of the match (e.g. 'F', 'SF', 'QF', 'R32').

    Returns:
    list: A list of Elo performance ratings for each condition provided in the conditions_list.
          The order of the ratings in the list corresponds to the order of conditions in the conditions_list.
    """
    results = []
    for condition in conditions_list:
        weeks = condition.get("weeks")
        surface = condition.get("surface")
        IOC = condition.get("IOC")
        tourney_name = condition.get("tourney_name")
        round_ = condition.get("round")
        tourney_level = condition.get("tourney_level")

        filtered_matches = matches.copy()

        if weeks is not None:
            if match_id:
                date_obj = datetime.strptime(match_id[:8], "%Y%m%d")
            else:
                date_obj = datetime.now()
            prior_date_obj = date_obj - timedelta(days=weeks * 7)
            prior_date_string = prior_date_obj.strftime("%Y%m%d")
            filtered_matches = [
                match
                for match in filtered_matches
                if match["match_id"] > prior_date_string
                and match["match_id"] < match_id
            ]

        if surface is not None:
            filtered_matches = [
                match for match in filtered_matches if match["surface"] == surface
            ]

        if IOC is not None:
            filtered_matches = [
                match for match in filtered_matches if match["tourney_IOC"] == IOC
            ]

        if tourney_name is not None:
            filtered_matches = [
                match
                for match in filtered_matches
                if simplify_name(match["tourney_name"]) == simplify_name(tourney_name)
            ]

        if round_ is not None:
            filtered_matches = [
                match for match in filtered_matches if match["round"] == round_
            ]

        if tourney_level is not None:
            filtered_matches = [
                match
                for match in filtered_matches
                if match["tourney_level"] == tourney_level
            ]

        if serve_rating_margin is not None:
            serve_rating, margin = serve_rating_margin
            filtered_matches = [
                match
                for match in filtered_matches
                if (
                    serve_rating - margin
                    <= match["A_avg_serve_rating"]
                    <= serve_rating + margin
                    and player_name == match["A_simplified_name"]
                )
                or (
                    serve_rating - margin
                    <= match["B_avg_serve_rating"]
                    <= serve_rating + margin
                    and player_name == match["B_simplified_name"]
                )
            ]

        player_initial_elo = 1500
        player_elo = player_initial_elo
        if len(filtered_matches) == 0:
            results.append(player_initial_elo)
        else:
            for match in filtered_matches:
                tourney_level = match["tourney_level"]
                elo_k = ELO_CONSTANTS[tourney_level]["K"]
                elo_s = ELO_CONSTANTS[tourney_level]["S"]
                if match["A_simplified_name"] == player_name:
                    opp_elo = match["B_elo"]
                    match_result = 1
                else:
                    opp_elo = match["A_elo"]
                    match_result = 0
                win_prob = 1 / (1 + 10 ** ((opp_elo - player_elo) / elo_s))
                player_elo = player_elo + elo_k * (match_result - win_prob)
            results.append(player_elo)
    return results


def get_peak_elo(player_name, match_id, matches):
    """
    Calculate the peak Elo performance rating for a tennis player.
    """
    player_peak_elo = 1500
    player_elo = player_peak_elo

    for match in matches:
        if (
            match["match_id"] >= match_id
        ):  # Skip matches that occur on or after the given match
            continue
        if match["A_simplified_name"] == player_name:
            player_elo = match["A_elo"]
        elif match["B_simplified_name"] == player_name:
            player_elo = match["B_elo"]
        else:
            continue

        if player_elo > player_peak_elo:
            player_peak_elo = player_elo

    return player_peak_elo


def days_since_debut(player_name, match_id, matches):
    """
    Calculate the number of years since a player's debut match.
    """
    match_date = datetime.strptime(match_id[:8], "%Y%m%d")
    player_debut = match_date
    for match in matches:
        if (
            match["A_simplified_name"] == player_name
            or match["B_simplified_name"] == player_name
        ):
            match_date = datetime.strptime(match["match_id"][:8], "%Y%m%d")
            if match_date < player_debut:
                player_debut = match_date
    return (match_date - player_debut).days


def get_elo_variance(player_name, match_id, matches, conditions_list):
    """
    Calculate the variance of a player's elo gains/losses.
    """
    # Sort matches by match_id, with the most recent match first
    matches = sorted(matches, key=lambda k: k["match_id"], reverse=True)

    results = []
    for condition in conditions_list:
        weeks = condition.get("weeks")
        surface = condition.get("surface")
        IOC = condition.get("IOC")
        tourney_name = condition.get("tourney_name")
        round_ = condition.get("round")
        tourney_level = condition.get("tourney_level")

        filtered_matches = matches.copy()

        if weeks is not None:
            if match_id:
                date_obj = datetime.strptime(match_id[:8], "%Y%m%d")
            else:
                date_obj = datetime.now()
            prior_date_obj = date_obj - timedelta(days=weeks * 7)
            prior_date_string = prior_date_obj.strftime("%Y%m%d")
            filtered_matches = [
                match
                for match in filtered_matches
                if match["match_id"] > prior_date_string
                and match["match_id"] < match_id
            ]

        if surface is not None:
            filtered_matches = [
                match for match in filtered_matches if match["surface"] == surface
            ]

        if IOC is not None:
            filtered_matches = [
                match for match in filtered_matches if match["tourney_IOC"] == IOC
            ]

        if tourney_name is not None:
            filtered_matches = [
                match
                for match in filtered_matches
                if simplify_name(match["tourney_name"]) == simplify_name(tourney_name)
            ]

        if round_ is not None:
            filtered_matches = [
                match for match in filtered_matches if match["round"] == round_
            ]

        if tourney_level is not None:
            filtered_matches = [
                match
                for match in filtered_matches
                if match["tourney_level"] == tourney_level
            ]

        elo_changes = []
        previous_elo = 0

        # Iterate through the matches in reverse order and find the first one with a match_id less than the given match_id
        for match in filtered_matches:
            if match["match_id"] < match_id:
                # Get the player's previous elo value
                if match["A_simplified_name"] == player_name:
                    if previous_elo != 0:
                        elo_changes.append(match["A_elo"] - previous_elo)
                    previous_elo = match["A_elo"]
                else:
                    if previous_elo != 0:
                        elo_changes.append(match["B_elo"] - previous_elo)
                    previous_elo = match["B_elo"]

        # calculate variance
        if len(elo_changes) > 1:
            results.append(
                sum(
                    [
                        (elo - sum(elo_changes) / len(elo_changes)) ** 2
                        for elo in elo_changes
                    ]
                )
                / len(elo_changes)
            )
        else:
            results.append(0)

    return results


def get_fatigue_scores(player_name, match_id, matches):
    """
    Returns a tuple of four fatigue scores:
    - The number of games played in the last match
    - The number of games played in the current tournament
    - The number of games played in the last 7 days
    - The number of games played in the last 30 days
    """

    # Initialize counts
    last_match_games = 0
    tournament_games = 0
    week_games = 0
    month_games = 0

    # Extract year, tournament from the current match_id
    current_tournament = "_".join(match_id.split("_")[:2])

    # Sort matches by match_id in descending order
    matches = sorted(matches, key=lambda k: k["match_id"], reverse=True)

    # Iterate through matches in reverse order (most recent first)
    for match in matches:
        if match["match_id"] < match_id:
            # Check if score is available
            if not match["score"]:
                continue

            # Calculate games in match, ignoring tiebreak scores
            if "_" not in match["score"]:
                scores = match["score"]
            else:
                scores = match["score"].split("_")

            games = sum(
                (
                    sum(
                        int(score[i])
                        for i in range(min(len(score), 2))
                        if score[i].isdigit()
                    )
                )
                for score in scores
            )

            # Compare match date to current date
            match_date = datetime.strptime(match["match_id"][:8], "%Y%m%d")
            current_date = datetime.strptime(match_id[:8], "%Y%m%d")
            delta = (current_date - match_date).days

            if delta > 30:
                break

            month_games += games

            if delta <= 14:
                week_games += games

            # Check if the match is in the current tournament
            if "_".join(match["match_id"].split("_")[:2]) == current_tournament:
                # Update tournament count
                tournament_games += games

            if last_match_games == 0:
                last_match_games = games

    return [last_match_games, tournament_games, week_games, month_games]


def get_match_stats(match, player_A, player_B, player_A_matches, player_B_matches):
    """
    Calculate match statistics for a given match.
    """
    X_dict = {}

    # X_dict["match_year"] = int(match["match_id"][:4]) - 1980

    X_dict["Hard"] = X_dict["Clay"] = X_dict["Grass"] = X_dict["Carpet"] = 0
    X_dict[match["surface"]] = 1

    X_dict["Future"] = X_dict["Master"] = X_dict["ATP"] = X_dict["Challenger"] = X_dict[
        "Grand Slam"
    ] = 0
    if match["tourney_level"] == "F":
        X_dict["Future"] = 1
    elif match["tourney_level"] == "M":
        X_dict["Master"] = 1
    elif match["tourney_level"] == "A":
        X_dict["ATP"] = 1
    elif match["tourney_level"] == "C":
        X_dict["Challenger"] = 1
    elif match["tourney_level"] == "G":
        X_dict["Grand Slam"] = 1

    X_dict["Q1"] = X_dict["Q2"] = X_dict["Q3"] = X_dict["Q4"] = X_dict["R128"] = X_dict[
        "R64"
    ] = X_dict["R32"] = X_dict["R16"] = X_dict["QF"] = X_dict["SF"] = X_dict[
        "F"
    ] = X_dict[
        "RR"
    ] = 0
    X_dict[match["round"]] = 1

    X_dict["A_previous_elo"] = get_previous_elo(
        player_A, match["match_id"], player_A_matches
    )
    X_dict["B_previous_elo"] = get_previous_elo(
        player_B, match["match_id"], player_B_matches
    )
    X_dict["A_peak_elo"] = get_peak_elo(player_A, match["match_id"], player_A_matches)
    X_dict["B_peak_elo"] = get_peak_elo(player_B, match["match_id"], player_B_matches)
    X_dict["A_days_since_debut"] = days_since_debut(
        player_A, match["match_id"], player_A_matches
    )
    X_dict["B_days_since_debut"] = days_since_debut(
        player_B, match["match_id"], player_B_matches
    )

    (
        X_dict["A_last_match_games"],
        X_dict["A_tournament_games"],
        X_dict["A_week_games"],
        X_dict["A_month_games"],
    ) = get_fatigue_scores(player_A, match["match_id"], player_A_matches)
    (
        X_dict["B_last_match_games"],
        X_dict["B_tournament_games"],
        X_dict["B_week_games"],
        X_dict["B_month_games"],
    ) = get_fatigue_scores(player_B, match["match_id"], player_B_matches)

    variance_conditions = [
        {"weeks": 64},
        {"weeks": 256},
        {"weeks": 99999},
        {"surface": match["surface"]},
        {"tourney_level": match["tourney_level"]},
        {"round": match["round"]},
    ]

    A_variance_stats = get_elo_variance(
        player_A, match["match_id"], player_A_matches, variance_conditions
    )
    B_variance_stats = get_elo_variance(
        player_B, match["match_id"], player_B_matches, variance_conditions
    )

    h2h_stats = get_h2h(
        [player_A, player_B],
        match["match_id"],
        player_A_matches,
        [
            {"weeks": 99999},
            {"weeks": 128},
            {"weeks": 32},
            {"surface": match["surface"]},
            {"surface": match["surface"], "weeks": 128},
            {"IOC": match["tourney_IOC"]},
            {"tourney_level": match["tourney_level"]},
            {"round": match["round"]},
        ],
    )

    performance_conditions = [
        {"weeks": 4},
        {"weeks": 8},
        {"weeks": 16},
        {"weeks": 32},
        {"weeks": 64},
        {"weeks": 128},
        {"weeks": 256},
        {"weeks": 512},
        {"surface": match["surface"], "weeks": 4},
        {"surface": match["surface"], "weeks": 8},
        {"surface": match["surface"], "weeks": 16},
        {"surface": match["surface"], "weeks": 32},
        {"surface": match["surface"], "weeks": 64},
        {"surface": match["surface"], "weeks": 128},
        {"surface": match["surface"], "weeks": 256},
        {"surface": match["surface"], "weeks": 512},
        {"IOC": match["tourney_IOC"]},
        {"IOC": match["tourney_IOC"], "weeks": 128},
        {"IOC": match["tourney_IOC"], "weeks": 256},
        {"tourney_name": match["tourney_name"]},
        {"tourney_name": match["tourney_name"], "weeks": 128},
        {"tourney_name": match["tourney_name"], "weeks": 256},
        {"round": match["round"]},
        {"round": match["round"], "weeks": 128},
        {"round": match["round"], "weeks": 256},
        {"tourney_level": match["tourney_level"]},
        {"tourney_level": match["tourney_level"], "weeks": 32},
        {"tourney_level": match["tourney_level"], "weeks": 64},
        {"tourney_level": match["tourney_level"], "weeks": 128},
        {"tourney_level": match["tourney_level"], "weeks": 256},
        {"tourney_level": match["tourney_level"], "surface": match["surface"]},
        {
            "tourney_level": match["tourney_level"],
            "surface": match["surface"],
            "weeks": 64,
        },
        {
            "tourney_level": match["tourney_level"],
            "surface": match["surface"],
            "weeks": 128,
        },
        {
            "tourney_level": match["tourney_level"],
            "surface": match["surface"],
            "weeks": 256,
        },
    ]

    A_performance_stats = get_elo_performance(
        player_A, match["match_id"], player_A_matches, performance_conditions
    )
    B_performance_stats = get_elo_performance(
        player_B, match["match_id"], player_B_matches, performance_conditions
    )
    A_win_loss_stats = get_win_loss_record(
        player_A, match["match_id"], player_A_matches, performance_conditions
    )
    B_win_loss_stats = get_win_loss_record(
        player_B, match["match_id"], player_B_matches, performance_conditions
    )

    A_win_loss_stats = [stat for stats in A_win_loss_stats for stat in stats]
    B_win_loss_stats = [stat for stats in B_win_loss_stats for stat in stats]

    h2h_stats_expanded = []
    for stats in h2h_stats:
        for stat in stats:
            h2h_stats_expanded.append(stat)

    data_list = (
        list(X_dict.values())
        + A_performance_stats
        + B_performance_stats
        + A_win_loss_stats
        + B_win_loss_stats
        + h2h_stats_expanded
        + A_variance_stats
        + B_variance_stats
    )

    return data_list
