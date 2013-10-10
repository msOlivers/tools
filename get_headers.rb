#!/usr/bin/ruby

require 'net/http'

def getHeader(host,port = nil)
  port = port || 80

  Net::HTTP.start(host.to_s, port) do |http|
    resp = http.head('/')
    return [resp['server'].to_s ,resp['x-powered-by'].to_s]
  end

  return [nil,nil]
end

if ARGV.size <= 0 || ARGV.size > 2
  print "Usage: #{$0} Host [Port]\n"
  exit
end

server, mods = getHeader(ARGV[0],ARGV[1])
print "Server #{server} (#{mods})\n"
