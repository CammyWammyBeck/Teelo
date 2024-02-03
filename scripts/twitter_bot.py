import tweepy

key = "ywuziqAU1DH4mrCGe10gAtlC6"
secret = "7im4z2WEj47uoK3GlnyjxMRARQ9ZHXLpUsVZqRgt6ZUVoLfrA5"
token = "1477453250471215104-Aa8njjg8JVGbJZo3n3CoCGhyNlJE2r"
token_secret = "Xuu9DQ82TjrSE4EgZLR4YXyjmrhoF1iviYvKN6lxgHexc"


class TwitterBot:
    def __init__(
        self, consumer_key, consumer_secret, access_token, access_token_secret
    ):
        self.consumer_key = consumer_key
        self.consumer_secret = consumer_secret
        self.access_token = access_token
        self.access_token_secret = access_token_secret
        self.authenticate()

    def authenticate(self):
        # Authenticate to Twitter
        self.api = tweepy.Client(
            consumer_key=self.consumer_key,
            consumer_secret=self.consumer_secret,
            access_token=self.access_token,
            access_token_secret=self.access_token_secret,
        )

    def tweet(self, tweets, tweet_as_thread=False):
        responses = []
        try:
            if tweet_as_thread:
                previous_tweet = None
                for tweet in tweets:
                    if previous_tweet is None:
                        response = self.api.create_tweet(text=tweet)
                    else:
                        response = self.api.create_tweet(
                            text=tweet, in_reply_to_tweet_id=response.data["id"]
                        )
                    responses.append(response)
                    previous_tweet = response
                print("Tweet thread posted successfully.")
            else:
                for tweet in tweets:
                    response = self.api.update_status(tweet)
                    responses.append(response)
                print("Tweets posted separately successfully.")
        except Exception as e:
            print("An error occurred: ", e)
            return None
        return responses


# Example usage:
# bot = TwitterBot(key, secret, token, token_secret)
# response = bot.tweet(["Hello, Twitter!"], tweet_as_thread=False)
# if response:
#     for tweet_response in response:
#         print(f"Tweeted: {tweet_response.text} (ID: {tweet_response.id})")
