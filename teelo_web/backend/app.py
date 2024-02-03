from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import desc
from sqlalchemy import or_
from sqlalchemy import case
from flask_cors import CORS
import os
from jellyfish import jaro_winkler_similarity
import timeit
from collections import defaultdict
import datetime

import sys
import os

# Add the parent directory of 'scripts' to sys.path
parent_dir = os.path.abspath(
    os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), ".")
)
sys.path.append(parent_dir)

from scripts.data_helpers import get_match_date, simplify_name
from scripts.stats import get_all_matches_for_player


app = Flask(__name__)
CORS(app)  # This will enable CORS for all routes

current_dir = os.path.dirname(os.path.abspath(__file__))
parent_dir = os.path.dirname(current_dir)
grandparent_dir = os.path.dirname(parent_dir)
app.config[
    "SQLALCHEMY_DATABASE_URI"
] = f"sqlite:///{grandparent_dir}/data/matches.sqlite"
db = SQLAlchemy(app)


class Match(db.Model):
    __tablename__ = "tennis_matches"
    match_id = db.Column(db.Integer, unique=True, nullable=False, primary_key=True)
    A_name = db.Column(db.String(80), nullable=False)
    B_name = db.Column(db.String(80), nullable=False)
    A_simplified_name = db.Column(db.String(80), nullable=False)
    B_simplified_name = db.Column(db.String(80), nullable=False)
    tourney_name = db.Column(db.String(80), nullable=False)
    tourney_level = db.Column(db.String(1), nullable=False)
    surface = db.Column(db.String(10), nullable=False)
    round = db.Column(db.String(5), nullable=False)
    A_elo = db.Column(db.Integer, nullable=False)
    B_elo = db.Column(db.Integer, nullable=False)

    def serialize(self):
        if self.A_elo == None:
            self.A_elo = 1500
        if self.B_elo == None:
            self.B_elo = 1500
        return {
            "match_id": self.match_id,
            "match_date": get_match_date(self.match_id, self.round, self.tourney_level),
            "A_name": self.A_name,
            "B_name": self.B_name,
            "A_simplified_name": self.A_simplified_name,
            "B_simplified_name": self.B_simplified_name,
            "tourney_name": self.tourney_name,
            "tourney_level": self.tourney_level,
            "surface": self.surface,
            "round": self.round,
            "A_elo": int(self.A_elo),
            "B_elo": int(self.B_elo),
        }


class Player(db.Model):
    __tablename__ = "player_data"
    player = db.Column(db.String(80), unique=True, nullable=False, primary_key=True)
    DOB = db.Column(db.String(8), nullable=False)
    IOC = db.Column(db.String(3), nullable=False)
    isActive = db.Column(db.Integer, nullable=False)

    def serialize(self):
        return {
            "player": self.player,
            "DOB": self.DOB,
            "IOC": self.IOC,
            "isActive": self.isActive,
        }


@app.route("/matches", methods=["GET"])
def get_matches():
    print("getting matches")
    start = int(request.args.get("start", 0))
    end = int(request.args.get("end", 100))
    player_name = request.args.get("player_name")
    print(player_name)
    tourney_level = request.args.get("tourney_level")
    surface = request.args.get("surface")

    query = Match.query

    if tourney_level:
        tourney_level = tourney_level.split(",")
        query = query.filter(Match.tourney_level.in_(tourney_level))
    if surface:
        surface = surface.split(",")
        query = query.filter(Match.surface.in_(surface))

    if player_name:
        query = query.filter(
            (Match.A_name.ilike(f"%{player_name}%"))
            | (Match.B_name.ilike(f"%{player_name}%"))
        )

    # Replace your limit logic with the following:
    matches = (
        query.order_by(desc(Match.match_id)).offset(start).limit(end - start).all()
    )

    print("List of matches")
    for match in matches:
        print(match.match_id, match.A_name, match.B_name)

    return jsonify([match.serialize() for match in matches])


@app.route("/get_player_elo", methods=["GET"])
def get_player_elo():
    player_name = simplify_name(request.args.get("player_name"))
    # tourney_level = request.args.get("tourney_level")
    # surface = request.args.get("surface")

    # if tourney_level:
    #     tourney_level = tourney_level.split(",")
    # if surface:
    #     surface = surface.split(",")

    query = Match.query

    if player_name and player_name != "":
        query = query.filter(
            (Match.A_simplified_name == player_name)
            | (Match.B_simplified_name == player_name)
        )
    # if tourney_level:
    #     query = query.filter(Match.tourney_level.in_(tourney_level))
    # if surface:
    #     query = query.filter(Match.surface.in_(surface))

    matches = query.order_by(desc(Match.match_id)).all()

    elo_values = []
    for match in matches:
        if match.A_simplified_name == player_name:
            elo_values.append(
                {
                    "date": get_match_date(
                        match.match_id, match.round, match.tourney_level
                    ),
                    "elo": match.A_elo,
                }
            )
        else:
            elo_values.append(
                {
                    "date": get_match_date(
                        match.match_id, match.round, match.tourney_level
                    ),
                    "elo": match.B_elo,
                }
            )

    return jsonify(elo_values)


@app.route("/get_player_rankings", methods=["GET"])
def get_player_rankings():
    num_rankings = request.args.get("num_rankings", default=10, type=int)

    # Get current date
    current_date = datetime.datetime.now()

    # Querying matches in descending order of match_id
    # Only query matches that are in the past 12 months
    # Convert match id of format YYYYMMDD_XXXX_XXX to datetime object first to compare to current date
    matches = (
        Match.query.filter(
            Match.match_id.like(f"{current_date.year - 1}%")
            | Match.match_id.like(f"{current_date.year}%")
        )
        .order_by(desc(Match.match_id))
        .all()
    )

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


@app.route("/get_player_info", methods=["GET"])
def get_player_stats():
    player_name = request.args.get("player_name")

    player_matches = get_all_matches_for_player(player_name)

    player_stats = get_player_statistics(player_name, player_matches)

    return jsonify(player_stats)


def get_all_matches_for_player(player_name):
    player_name = simplify_name(player_name)
    matches = Match.query.filter(
        (Match.A_simplified_name == player_name)
        | (Match.B_simplified_name == player_name)
    ).all()

    return matches


def get_player_statistics(player_name, matches):
    player_name = simplify_name(player_name)

    match_count = len(matches)
    win_count = 0
    loss_count = 0
    current_elo = 1500
    peak_elo = 1500
    for match in matches:
        if match.A_simplified_name == player_name:
            win_count += 1
        else:
            loss_count += 1

        player_elo = (
            int(match.A_elo)
            if match.A_simplified_name == player_name
            else int(match.B_elo)
        )
        if player_elo > peak_elo:
            peak_elo = player_elo

        if win_count + loss_count == match_count:
            current_elo = player_elo

    return [
        {"value_name": "Match Count", "value": match_count},
        {"value_name": "Win Count", "value": win_count},
        {"value_name": "Loss Count", "value": loss_count},
        {"value_name": "Current Elo", "value": current_elo},
        {"value_name": "Peak Elo", "value": peak_elo},
    ]


if __name__ == "__main__":
    app.run(debug=True, host="192.168.20.4", port=5000)
