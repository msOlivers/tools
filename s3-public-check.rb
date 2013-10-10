#!/usr/bin/env ruby

# Chris Fernandez - Pentester CEHv7 rek2gnulinux@gmail.com
# quick durty script to put in practice the idea of the 
# post in security street from rapid7
# https://community.rapid7.com/community/infosec/blog/2013/03/27/1951-open-s3-buckets

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>

require 'net/http'
require 'uri'

def s3get(url)

  begin
    target = URI.parse(url)
  rescue URI::InvalidURIError => err
    p err
    exit
   end

  if target.host && target.port
    http = Net::HTTP.new(target.host, target.port) 
    res = http.head("/")
    if res.code ==  "200"
      print "#{res.code} :  #{target} <-------- PUBLIC\n"
    end
  else
    p "Error parsing url #{target}"
  end

end


File.open('rockyou.txt', 'r') do |file|
  file.each_line do |line|
    line.chomp!
    url = "http://#{line}.s3.amazonaws.com"
    url2 = "http://s3.amazonaws.com/#{line}"
      response = s3get(url)
      response2 = s3get(url2)
  end
end 
