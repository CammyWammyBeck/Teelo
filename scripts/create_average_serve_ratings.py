from alive_progress import alive_bar
import sqlite3
import sys
from pathlib import Path
import time
import pandas as pd


def import_utilities_module():
    project_root = Path(__file__).resolve().parents[2]
    sys.path.append(str(project_root))

    from utilities.stats import get_all_matches_for_player
    return get_all_matches_for_player


get_all_matches_for_player = import_utilities_module()

conn = sqlite3.connect('../matches.sqlite')
cur = conn.cursor()


def update_serve_ratings_data(player_name, serve_rating, serve_ratings_data):
    if player_name not in serve_ratings_data:
        serve_ratings_data[player_name] = {'total_serve_rating': 0, 'count': 0}

    if not serve_rating:
        return None

    serve_ratings_data[player_name]['total_serve_rating'] += float(serve_rating)
    serve_ratings_data[player_name]['count'] += 1

    return serve_ratings_data[player_name]['total_serve_rating'] / serve_ratings_data[player_name]['count']


def update_average_serve_ratings():
    player_matches = {}

    # Read the tennis_matches table into a pandas DataFrame
    matches_df = pd.read_sql_query("SELECT * FROM tennis_matches", conn)

    # Calculate average serve ratings for all rows using apply function
    matches_df['A_avg_serve_rating'] = matches_df.apply(
        lambda row: update_serve_ratings_data(row['A_name'], row['A_serve_rating'], player_matches), axis=1)
    matches_df['B_avg_serve_rating'] = matches_df.apply(
        lambda row: update_serve_ratings_data(row['B_name'], row['B_serve_rating'], player_matches), axis=1)

    # Replace the entire tennis_matches table with the updated DataFrame
    matches_df.to_sql('tennis_matches', conn, if_exists='replace', index=False)


if __name__ == "__main__":
    update_average_serve_ratings()
    conn.close()
