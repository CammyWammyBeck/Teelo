from scripts.create_elo import create_elo
from scripts.scrape_data_to_sqlite import scrape_data_to_sqlite
from scripts.predict import predict_main
import datetime
import time
from scripts.twitter_bot import TwitterBot
from scripts.database_management import delete_tourney
from scripts.get_data import get_rankings
import sqlite3
import traceback


def process_and_tweet_matches(predicted_matches):
    bot = TwitterBot(
        "ywuziqAU1DH4mrCGe10gAtlC6",
        "7im4z2WEj47uoK3GlnyjxMRARQ9ZHXLpUsVZqRgt6ZUVoLfrA5",
        "1477453250471215104-Aa8njjg8JVGbJZo3n3CoCGhyNlJE2r",
        "Xuu9DQ82TjrSE4EgZLR4YXyjmrhoF1iviYvKN6lxgHexc",
    )

    if len(predicted_matches) > 0:
        strings_to_tweet = []
        tweet = ""
        print("Tweeting predictions", predicted_matches)
        for match in predicted_matches:
            sub_tweet = (
                f"{match['prediction']*100:.2f}%/{(1-match['prediction'])*100:.2f}% - "
                f"{match['A_name'].strip()} vs. {match['B_name'].strip()}, "
                f"{match['tourney_name'].replace('-', ' ').title()}, {match['round']}"
            )

            print(sub_tweet)

            if len(tweet) + len(sub_tweet) > 280 - 41:
                strings_to_tweet.append(
                    tweet + "\n#tennis #atp #elo #sportstips #tennistips"
                )
                tweet = ""

            tweet += "\n" + sub_tweet

        if len(tweet) > 0:
            strings_to_tweet.append(
                tweet + "\n#tennis #atp #elo #sportstips #tennistips"
            )

        print(strings_to_tweet)

        response = bot.tweet(strings_to_tweet, tweet_as_thread=True)
        if response:
            for tweet_response in response:
                print(f"Tweeted: {tweet_response})")
        else:
            print("Error tweeting predictions")


def process_and_tweet_rankings(num_rankings):
    try:
        bot = TwitterBot(
            "ywuziqAU1DH4mrCGe10gAtlC6",
            "7im4z2WEj47uoK3GlnyjxMRARQ9ZHXLpUsVZqRgt6ZUVoLfrA5",
            "1477453250471215104-Aa8njjg8JVGbJZo3n3CoCGhyNlJE2r",
            "Xuu9DQ82TjrSE4EgZLR4YXyjmrhoF1iviYvKN6lxgHexc",
        )

        rankings_data = get_rankings(num_rankings)

        if num_rankings > 0:
            strings_to_tweet = []
            tweet = ""
            print(f"Tweeting {num_rankings} rankings")
            for player in rankings_data:
                sub_tweet = f"Rank {player['rank']} - {player['name']} ({player['elo']:.2f} ELO)"

                if len(tweet) + len(sub_tweet) > 280 - 27:
                    strings_to_tweet.append(tweet + "\n#tennis #atp #elo #rankings")
                    tweet = ""

                tweet += "\n" + sub_tweet

            if len(tweet) > 0:
                strings_to_tweet.append(
                    tweet + "\n#tennis #atp #elo #sportstips #tennistips"
                )

            print(strings_to_tweet)

            response = bot.tweet(strings_to_tweet, tweet_as_thread=True)
            if response:
                for tweet_response in response:
                    print(f"Tweeted: {tweet_response})")
            else:
                print("Error tweeting rankings")
    except Exception as e:
        print("Error tweeting rankings")
        print(e)
        traceback.print_exc()


def update():
    # conn = sqlite3.connect("data/matches.sqlite")
    # c = conn.cursor()

    # delete_tourney(c, conn, "2024", "9158")

    # conn.close()

    scrape_data_to_sqlite(2024, 2024, update=True, overwrite=False)
    create_elo(update=True)
    predicted_matches = predict_main()
    process_and_tweet_matches(predicted_matches)
    process_and_tweet_rankings(10)
    return


if __name__ == "__main__":
    run_scheduler = True
    run_input = input("Run scheduler? (y/n): ")
    if run_input.lower() == "n":
        run_scheduler = False

    update()
    print(f"Database updated at {datetime.datetime.now()}")

    if not run_scheduler:
        exit()

    last_update = datetime.datetime.now()

    while True:
        now = datetime.datetime.now()
        seconds_before_next_update = (
            last_update + datetime.timedelta(hours=3) - now
        ).total_seconds()

        if seconds_before_next_update < 0:
            last_update = now
            update()
            print(f"Database updated at {now}")
        else:
            print(f"Next update at {last_update + datetime.timedelta(hours=3)}")
            time.sleep(max(60, seconds_before_next_update))
