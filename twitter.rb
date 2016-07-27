require 'twitter'
require 'yaml'
require 'pry'

class TwitterApi
  attr_reader :client

  def initialize
    keys = YAML.load_file('application.yml')
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = keys['CONSUMER_KEY']
      config.consumer_secret     = keys['CONSUMER_SECRET']
      config.access_token        = keys['ACCESS_TOKEN']
      config.access_token_secret = keys['ACCESS_TOKEN_SECRET']
    end
  end


  def most_recent_friend
    client.friends.first.name
  end

  def find_user_for(username)
    client.user(username).name
  end

  def find_followers_for(username)
    #find the twitter gem method that returns the follows of a given user
    
    first_ten_followers = []

    client.followers(username).each do |user|
      if first_ten_followers.length == 10
        break
      else
        first_ten_followers << user.name
      end
    end

    return first_ten_followers
  end

  def homepage_timeline
    client.home_timeline.collect do |tweet|
      tweet.text
    end
  end
  
end

#Bonus: 

# uncomment out the following and read the bonus instructions.
# remember to comment out the WebMock line of your spec_helper, as the instructions dictate.

tweet_client = TwitterApi.new
puts tweet_client.most_recent_friend
puts tweet_client.find_user_for("kallaugher")
puts tweet_client.find_followers_for("kallaugher")
puts tweet_client.homepage_timeline
