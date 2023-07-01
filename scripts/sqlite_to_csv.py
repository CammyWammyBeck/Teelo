import sqlite3
import pandas as pd
import os

db_file = "data/matches.sqlite"
output_csv = "data/matches_sqlite.csv"

# Read the SQLite database
with sqlite3.connect(db_file) as conn:
    df = pd.read_sql("SELECT * FROM tennis_matches ORDER BY match_id", conn)

# Save the DataFrame to a CSV file
df = df.sort_values(by="match_id")
df.to_csv(output_csv, index=False)
print(f"Data saved to {output_csv}")
