#!/usr/bin/env ruby

#gem install rufus-scheduler
#gem install colorize
#gem install twitter


require 'twitter'
require 'rufus-scheduler'
require 'colorize'

@client = Twitter::Streaming::Client.new do |config|
  config.consumer_key = ENV[ 'TWITTER_CONSUMER_KEY' ]
  config.consumer_secret = ENV[ 'TWITTER_CONSUMER_SECRECT' ]
  config.access_token =  ENV[ 'TWITTER_OAUTH_TOKEN' ]
  config.access_token_secret = ENV[ 'TWITTER_OAUTH_TOKEN_SECRECT' ]
end


#  system "clear"
#  @client.home_timeline.each do |t|
#    puts "#{t.user.screen_name}:".red +  "#{t.text}".green
#  end
#end


#scheduler = Rufus::Scheduler.new 
#check()
#scheduler.every '1m' do
#  check()
#end

#scheduler.join

topics = ["cybersecurity", "infosec", "cyberwar", "hacking"]
@client.filter(track: topics.join(",")) do |object|
  puts "#{object.text}" if object.is_a?(Twitter::Tweet)
end
