from scripts.create_elo import create_elo
from scripts.scrape_data_to_sqlite import scrape_data_to_sqlite
from scripts.predict import predict_main


def main():
    scrape_data_to_sqlite(2023, 2023, update=True, overwrite=False)
    create_elo(update=False)
    predict_main()


if __name__ == "__main__":
    main()
