#!/usr/bin/env ruby

# Christian Fernandez Hispagatos.org binaryfreedom
# gem install cinch
# gem install cinch_channel_list


require "cinch"
require 'cinch_channel_list'

#here we write msg, like "visit https://www.reddit.com/r/HackBloc/ WAKE UP!"
#change to your own taste.
Propaganda = "Hello..."

def join_channels(channels)
  channels = File.foreach("channels-list")
end


bot = Cinch::Bot.new do
  configure do |c|
    c.server = "chat.freenode.net" #connect to I2p-IRC 
    c.port = "6667"
    c.delay_joins = 3
    c.channels = join_channels(channels)
    c.nick = "Meow"
    c.plugins.plugins = [ChannelList]
  end

  on :connect do 
    @bot.handlers.dispatch(:get_channel_list)
  end

  on :channel_list_received do |m, channels|
    File.open("channels-list2",  "w") do |chan|
      channels.each do |k,v|
        bot.join("#{k}")
 	sleep(2)
        Channel("#{k}").send("#{Propaganda}")
        chan.puts "#{k}" #this is just to keep a log
	sleep(1)
        bot.part("#{k}")
      end
    @bot.quit
    end
  end
end

bot.start
