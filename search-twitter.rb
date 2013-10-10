#!/usr/bin/env ruby
# gem install colorize
# gem install twitter

require 'twitter'
require 'colorize'

Twitter.configure do |config|
  config.consumer_key = 'xxxxxx'
  config.consumer_secret = 'xxxxxx'
  config.oauth_token = 	'xxxx'
  config.oauth_token_secret = 'xxxxx'
end

ARGV.each do |a|
  Twitter.search("#{a}", :count => "200").results.map do |s|
    puts "#{s.from_user}:".red + "#{s.text}".green
  end
end
