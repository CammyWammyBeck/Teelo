from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import desc
from flask_cors import CORS
import os
from jellyfish import jaro_winkler_similarity
import timeit

import sys
import os

# Add the parent directory of 'scripts' to sys.path
parent_dir = os.path.abspath(
    os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), ".")
)
sys.path.append(parent_dir)

from scripts.data_helpers import get_match_date


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
    tourney_name = db.Column(db.String(80), nullable=False)
    tourney_level = db.Column(db.String(1), nullable=False)
    surface = db.Column(db.String(10), nullable=False)
    round = db.Column(db.String(5), nullable=False)
    A_elo = db.Column(db.Integer, nullable=False)
    B_elo = db.Column(db.Integer, nullable=False)

    def serialize(self):
        return {
            "match_id": self.match_id,
            "match_date": get_match_date(self.match_id, self.round, self.tourney_level),
            "A_name": self.A_name,
            "B_name": self.B_name,
            "tourney_name": self.tourney_name,
            "tourney_level": self.tourney_level,
            "surface": self.surface,
            "round": self.round,
            "A_elo": int(self.A_elo),
            "B_elo": int(self.B_elo),
        }


@app.route("/matches", methods=["GET"])
def get_matches():
    player_name = request.args.get("player_name")
    tourney_level = request.args.get("tourney_level")
    surface = request.args.get("surface")

    if tourney_level:
        tourney_level = tourney_level.split(",")
    if surface:
        surface = surface.split(",")

    query = Match.query

    if player_name and player_name != "":
        query = query.filter(
            (Match.A_name == player_name) | (Match.B_name == player_name)
        )
    if tourney_level:
        query = query.filter(Match.tourney_level.in_(tourney_level))
    if surface:
        query = query.filter(Match.surface.in_(surface))

    matches = query.order_by(desc(Match.match_id)).limit(500).all()

    if len(matches) == 0 and player_name != "":
        # search for matches where player_name is in the name
        print("searching for matches where player_name is in the name")
        query = Match.query
        if tourney_level:
            query = query.filter(Match.tourney_level.in_(tourney_level))
        if surface:
            query = query.filter(Match.surface.in_(surface))
        matches = (
            query.filter(
                (Match.A_name.like(f"%{player_name}%"))
                | (Match.B_name.like(f"%{player_name}%"))
            )
            .order_by(desc(Match.match_id))
            .limit(500)
            .all()
        )

    if len(matches) == 0 and player_name != "":
        # search for close matches to player_name, using jarowinkler distance
        print("searching for close matches")
        # start timer
        start = timeit.default_timer()
        matches = []
        offset = 0
        while len(matches) < 500:
            query = Match.query
            if tourney_level:
                query = query.filter(Match.tourney_level.in_(tourney_level))
            if surface:
                query = query.filter(Match.surface.in_(surface))
            potential_matches = (
                query.order_by(desc(Match.match_id)).offset(offset).limit(500).all()
            )
            for match in potential_matches:
                jw_distance_A = jaro_winkler_similarity(player_name, match.A_name)
                jw_distance_B = jaro_winkler_similarity(player_name, match.B_name)
                if jw_distance_A > 0.9 or jw_distance_B > 0.9:
                    matches.append(match)
                    print(f"found match: {match.A_name} vs {match.B_name}")
            offset += 500
            # lap timer
            stop = timeit.default_timer()
            if len(potential_matches) < 500 or stop - start > 15:
                break
        matches = matches[:100]

    return jsonify([match.serialize() for match in matches])


@app.route("/get_player_elo", methods=["GET"])
def get_player_elo():
    player_name = request.args.get("player_name")
    # tourney_level = request.args.get("tourney_level")
    # surface = request.args.get("surface")

    # if tourney_level:
    #     tourney_level = tourney_level.split(",")
    # if surface:
    #     surface = surface.split(",")

    query = Match.query

    if player_name and player_name != "":
        query = query.filter(
            (Match.A_name == player_name) | (Match.B_name == player_name)
        )
    # if tourney_level:
    #     query = query.filter(Match.tourney_level.in_(tourney_level))
    # if surface:
    #     query = query.filter(Match.surface.in_(surface))

    matches = query.order_by(desc(Match.match_id)).all()

    elo_values = []
    for match in matches:
        if match.A_name == player_name:
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


if __name__ == "__main__":
    app.run(debug=True, host="192.168.20.3", port=5000)
