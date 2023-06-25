import sqlite3
import pandas as pd

input_csv = "../matches_sqlite.csv"
db_file = "../matches.sqlite"

# Read the updated CSV file
df = pd.read_csv(input_csv, dtype=str)

# Establish a connection to the SQLite database
with sqlite3.connect(db_file) as conn:
    # Get existing columns in the tennis_matches table
    existing_columns = [
        col[1] for col in conn.execute("PRAGMA table_info(tennis_matches)")
    ]

    # Add missing columns to the tennis_matches table
    for col in df.columns:
        if col not in existing_columns:
            conn.execute(f"ALTER TABLE tennis_matches ADD COLUMN {col} TEXT")

    # Clear existing data from the tennis_matches table
    conn.execute("DELETE FROM tennis_matches")

    # Create a list of column names and placeholders for the INSERT OR REPLACE statement
    columns = ", ".join(df.columns)
    placeholders = ", ".join("?" * len(df.columns))

    # Prepare the INSERT OR REPLACE statement
    insert_or_replace_query = (
        f"INSERT INTO tennis_matches ({columns}) VALUES ({placeholders})"
    )

    # Execute the statement for all rows in the DataFrame
    conn.executemany(insert_or_replace_query, df.values.tolist())

print(f"SQLite database {db_file} updated with data from {input_csv}")
