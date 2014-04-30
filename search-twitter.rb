#!/usr/bin/env ruby
# gem install colorize
# gem install twitter

# WARNING API changed need to update

require 'twitter'
require 'colorize'

@client = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV[ 'TWITTER_CONSUMER_KEY' ]
  config.consumer_secret = ENV[ 'TWITTER_CONSUMER_SECRECT' ]
  config.oauth_token =  ENV[ 'TWITTER_OAUTH_TOKEN' ]
  config.oauth_token_secret = ENV[ 'TWITTER_OAUTH_TOKEN_SECRECT' ]
end



ARGV.each do |a|
  @client.search("#{a}", :count => "200").results.map do |s|
    puts "#{s.from_user}:".red + "#{s.text}".green
  end
end
