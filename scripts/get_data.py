import sqlite3
import datetime


def get_rankings(num_rankings=10):
    # Connect to the SQLite database
    conn = sqlite3.connect("data/matches.sqlite")
    cursor = conn.cursor()

    # Get current date
    current_date = datetime.datetime.now()

    # Querying matches in descending order of match_id
    # Only query matches that are in the past 12 months
    # Convert match id of format YYYYMMDD_XXXX_XXX to datetime object first to compare to current date
    query = f"""
        SELECT *
        FROM tennis_matches
        WHERE match_id LIKE '{current_date.year - 1}%'
            OR match_id LIKE '{current_date.year}%'
        ORDER BY match_id DESC
    """
    cursor.execute(query)
    matches = cursor.fetchall()

    # Looping through matches to get the most recent ELO for each player
    rankings = {}
    for match in matches:
        if match.A_elo == None:
            match.A_elo = 1500
        if match.B_elo == None:
            match.B_elo = 1500

        if match.A_name not in rankings:
            rankings[match.A_name] = round(match.A_elo, 0)
        if match.B_name not in rankings:
            rankings[match.B_name] = round(match.B_elo, 0)

    sorted_rankings = sorted(rankings.items(), key=lambda x: x[1], reverse=True)

    # Convert sorted_rankings into list of name-elo pairs with rank number for each
    sorted_rankings = [
        {"rank": i + 1, "name": name, "elo": elo, "id": i + 1}
        for i, (name, elo) in enumerate(sorted_rankings)
    ]

    # Return top num_rankings players
    if num_rankings == 0:
        return sorted_rankings
    return sorted_rankings[:num_rankings]
