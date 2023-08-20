ELO_CONSTANTS_LIST = [46, 309, 36, 355, 28, 422, 27, 459, 30, 359]

ELO_CONSTANTS = {
    "F": {"K": ELO_CONSTANTS_LIST[0], "S": ELO_CONSTANTS_LIST[1]},
    "C": {"K": ELO_CONSTANTS_LIST[2], "S": ELO_CONSTANTS_LIST[3]},
    "A": {"K": ELO_CONSTANTS_LIST[4], "S": ELO_CONSTANTS_LIST[5]},
    "M": {"K": ELO_CONSTANTS_LIST[6], "S": ELO_CONSTANTS_LIST[7]},
    "G": {"K": ELO_CONSTANTS_LIST[8], "S": ELO_CONSTANTS_LIST[9]},
}

performance_labels = [
    "weeks_4",
    "weeks_8",
    "weeks_16",
    "weeks_32",
    "weeks_64",
    "weeks_128",
    "weeks_256",
    "weeks_512",
    "surface_weeks_4",
    "surface_weeks_8",
    "surface_weeks_16",
    "surface_weeks_32",
    "surface_weeks_64",
    "surface_weeks_128",
    "surface_weeks_256",
    "surface_weeks_512",
    "IOC",
    "IOC_weeks_128",
    "IOC_weeks_256",
    "tourney_name",
    "tourney_name_weeks_128",
    "tourney_name_weeks_256",
    "round",
    "round_weeks_128",
    "round_weeks_256",
    "tourney_level",
    "tourney_level_weeks_32",
    "tourney_level_weeks_64",
    "tourney_level_weeks_128",
    "tourney_level_weeks_256",
    "tourney_level_surface",
    "tourney_level_surface_weeks_64",
    "tourney_level_surface_weeks_128",
    "tourney_level_surface_weeks_256",
]

labels = [
    "Hard",
    "Clay",
    "Grass",
    "Carpet",
    "Future",
    "Master",
    "ATP",
    "Challenger",
    "Grand Slam",
    "Q1",
    "Q2",
    "Q3",
    "Q4",
    "R128",
    "R64",
    "R32",
    "R16",
    "QF",
    "SF",
    "F",
    "RR",
    "A_previous_elo",
    "B_previous_elo",
    "A_peak_elo",
    "B_peak_elo",
    "A_days_since_debut",
    "B_days_since_debut",
    # "A_last_match_games",
    # "A_tournament_games",
    # "A_year_games",
    # "B_last_match_games",
    # "B_tournament_games",
    # "B_year_games",
]

h2h_labels = [
    "weeks_99999",
    "weeks_128",
    "weeks_32",
    "surface",
    "surface_weeks_128",
    "IOC",
    "tourney_level",
    "round",
]


# Adding labels for the performance stats and win-loss stats for both players
for label in performance_labels:
    labels.append("A_" + label)
for label in performance_labels:
    labels.append("B_" + label)
for label in performance_labels:
    labels.append("A_wins_" + label)
    labels.append("A_losses_" + label)
for label in performance_labels:
    labels.append("B_wins_" + label)
    labels.append("B_losses_" + label)
# for label in h2h_labels:
#     labels.append("A_h2h_" + label)
#     labels.append("B_h2h_" + label)

STAT_LABELS = labels
