#!/usr/bin/env ruby

require 'open3'
require 'socket'

def monitor(int_name)

  stdin, stdout, status = Open3.capture3("ifconfig #{int_name} down") 
  puts stdin
  puts stdout
  puts status

  stdin, stdout, status = Open3.capture3("macchanger  -A #{int_name}")
  puts stdin
  puts stdout
  puts status

  stdin, stdout, status = Open3.capture3("iwconfig #{int_name} mode monitor")
  puts stdin
  puts stdout
  puts status

  stdin, stdout, status = Open3.capture3("ifconfig #{int_name} up")
  puts stdin
  puts stdout
  puts status

end

user = `id -u`
if user.to_i != 0 
  puts "you need to run this script as root!!!"
  exit()
end

interfaces = Socket.getifaddrs.map { |i| i.name }.compact
list = Hash[(1...interfaces.size).zip interfaces]
list.each do |l, v|
  puts "#{l} #{v}"
end


puts "enter interface number to put in monitor mode"
int_number = gets
if  list.key?(int_number.to_i)
  monitor(list.fetch(int_number.to_i))
else
  puts "Selected interface does not exists"
end
