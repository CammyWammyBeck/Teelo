import math
from datetime import datetime, timedelta

import pandas as pd
from dateutil.relativedelta import relativedelta

from config.config import ELO_CONSTANTS


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


def get_h2h(player_A_name, player_B_name, match_id, matches):
    """
    Get the head-to-head record between two players.
    """
    player_A_h2h = 0
    player_B_h2h = 0
    for match in matches:
        if (
            match["match_id"] >= match_id
        ):  # Skip matches that occur on or after the given match
            continue
        if (
            match["A_simplified_name"] == player_A_name
            and match["B_simplified_name"] == player_B_name
        ):
            player_A_h2h += 1
        elif (
            match["A_simplified_name"] == player_B_name
            and match["B_simplified_name"] == player_A_name
        ):
            player_B_h2h += 1

    return [player_A_h2h, player_B_h2h]


def get_previous_elo(player_name, match_id, matches):
    # Iterate through the matches in reverse order and find the first one with a match_id less than the given match_id
    for match in reversed(matches):
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
                    - A_name (str): Name of player A.
                    - A_elo (int): Elo rating for player A.
                    - B_name (str): Name of player B.
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
                if match["tourney_name"] == tourney_name
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
                    - A_name (str): Name of player A.
                    - A_elo (int): Elo rating for player A.
                    - B_name (str): Name of player B.
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
                if match["tourney_name"] == tourney_name
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


def get_match_stats(match, player_A, player_B, player_A_matches, player_B_matches):
    """
    Calculate match statistics for a given match.
    """
    X_dict = {}
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
    X_dict["A_h2h"], X_dict["B_h2h"] = get_h2h(
        player_A, player_B, match["match_id"], player_A_matches
    )

    performance_conditions = [
        {"weeks": 4},
        {"weeks": 8},
        {"weeks": 16},
        {"weeks": 32},
        {"weeks": 64},
        {"surface": match["surface"], "weeks": 4},
        {"surface": match["surface"], "weeks": 8},
        {"surface": match["surface"], "weeks": 16},
        {"surface": match["surface"], "weeks": 32},
        {"surface": match["surface"], "weeks": 64},
        {"IOC": match["tourney_IOC"]},
        {"tourney_name": match["tourney_name"]},
        {"round": match["round"]},
        {"tourney_level": match["tourney_level"]},
        {"tourney_level": match["tourney_level"], "weeks": 32},
        {"tourney_level": match["tourney_level"], "surface": match["surface"]},
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

    data_list = (
        list(X_dict.values())
        + A_performance_stats
        + B_performance_stats
        + A_win_loss_stats
        + B_win_loss_stats
    )

    return data_list
