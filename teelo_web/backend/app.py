from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # This will enable CORS for all routes

# app.config["SQLALCHEMY_DATABASE_URI"] = "../../../data/matches.sqlite"
# db = SQLAlchemy(app)


# class Match(db.Model):
#     id = db.Column(db.Integer, primary_key=True)
#     match_id = db.Column(db.Integer, unique=True, nullable=False)
#     player_A = db.Column(db.String(80), nullable=False)
#     player_B = db.Column(db.String(80), nullable=False)
#     tourney_name = db.Column(db.String(80), nullable=False)
#     tourney_level = db.Column(db.String(1), nullable=False)
#     surface = db.Column(db.String(10), nullable=False)
#     round = db.Column(db.String(5), nullable=False)
#     A_elo = db.Column(db.Integer, nullable=False)
#     B_elo = db.Column(db.Integer, nullable=False)

#     def serialize(self):
#         return {
#             "match_id": self.match_id,
#             "player_A": self.player_A,
#             "player_B": self.player_B,
#             "tourney_name": self.tourney_name,
#             "tourney_level": self.tourney_level,
#             "surface": self.surface,
#             "round": self.round,
#             "A_elo": self.A_elo,
#             "B_elo": self.B_elo,
#         }


@app.route("/matches", methods=["GET"])
def get_matches():
    # player_name = request.args.get("player_name")
    # tourney_level = request.args.get("tourney_level")
    # surface = request.args.get("surface")

    # query = Match.query

    # if player_name:
    #     query = query.filter(
    #         (Match.player_A == player_name) | (Match.player_B == player_name)
    #     )
    # if tourney_level:
    #     query = query.filter(Match.tourney_level == tourney_level)
    # if surface:
    #     query = query.filter(Match.surface == surface)

    # matches = query.all()
    # return jsonify([match.serialize() for match in matches])
    return jsonify(
        [
            {
                "match_id": 1,
                "player_A": "Roger Federer",
                "player_B": "Rafael Nadal",
                "tourney_name": "Australian Open",
                "tourney_level": "G",
                "surface": "Hard",
                "round": "F",
                "A_elo": 2000,
                "B_elo": 2000,
            }
        ]
    )


if __name__ == "__main__":
    app.run(debug=True)
