#!/usr/bin/env ruby



channels = File.readlines("channels-list")
channels.each do |channel|
  print "#{channel}"
end
