#!/usr/bin/env ruby

#gem install rufus-scheduler
#gem install colorize
#gem install twitter


require 'twitter'
require 'colorize'

topics = ["cybersecurity", "infosec", "cyberwar", "hacking"]

@client = Twitter::Streaming::Client.new do |config|
  config.consumer_key = ENV[ 'TWITTER_CONSUMER_KEY' ]
  config.consumer_secret = ENV[ 'TWITTER_CONSUMER_SECRECT' ]
  config.access_token =  ENV[ 'TWITTER_OAUTH_TOKEN' ]
  config.access_token_secret = ENV[ 'TWITTER_OAUTH_TOKEN_SECRECT' ]
end

@client.filter(track: topics.join(",")) do |object|
 # puts "#{object.text}" if object.is_a?(Twitter::Tweet)
   puts "#{object.user.screen_name.yellow} - #{object.text.white}"  if object.is_a?(Twitter::Tweet)

end
