#!/usr/bin/env ruby

require 'twitter'
require 'rufus/scheduler'
require 'eventmachine'
require 'colorize'

Twitter.configure do |config|
  config.consumer_key = 'xxxxxxxxx'
  config.consumer_secret = 'xxxxxxxx'
  config.oauth_token = 	'xxxxxxxxxxx'
  config.oauth_token_secret = 'xxxxxxxx'
end


def check() 
  system "clear"
  Twitter.home_timeline.each do |t|
    puts "#{t.from_user}:".red +  "#{t.text}".green
  end
end


EM.run do
  scheduler = Rufus::Scheduler::EmScheduler.start_new
  
  check()
  scheduler.every '1m' do
    check()
  end
end
