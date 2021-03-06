#!/usr/bin/env ruby
# Christian Fernandez 2014 Hispagatos.org
# Script to check if email is possible fake or not
# script on alpha stage.. the idea is to pass eventually
# name combinations of someone, organization or company to
# find all possible email accounts they may hace across popular
# email networks like gmail, hotmail etc.. and their own domains linked


require 'resolv'
require 'net/smtp'

address = ARGV[0].chomp
domain = address.split('@').last
dns = Resolv::DNS.new

puts "Resolving MX records for #{domain}..."
mx_records = dns.getresources domain, Resolv::DNS::Resource::IN::MX
mx_server  = mx_records.first.exchange.to_s
puts "Connecting to #{mx_server}..."

Net::SMTP.start mx_server, 25 do |smtp|
  smtp.helo "hispagatos.org"
  smtp.mailfrom "meow@hispagatos.org"

  puts "Pinging #{address}..."

  puts "-" * 50

  begin
    smtp.rcptto address
    puts "Address probably exists."
  rescue Net::SMTPFatalError => err
    puts "Address probably doesn't exist."
  end
end
