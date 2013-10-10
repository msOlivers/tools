#!/usr/bin/env ruby

require 'net/http'
require 'uri'

uri = URI.parse("http://www.binaryfreedom.info")

http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new("/")
response = http.request(request)

case response.code.to_i
when 200 || 201
  p [:success]
when (400..499)
  p [:bad_request]
when (500..599)
  p [:server_problems]
end

print response.body
