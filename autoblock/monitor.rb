#!/usr/bin/env ruby
# gem install file-tail
# By cfernandez rek2gnulinux@gmail.com

require 'file-tail'

filename = "/var/log/auth.log"

File.open(filename) do |log|
  log.extend(File::Tail)
  log.interval = 10
  log.backward(1)
  log.tail do |line|
    next if line  !~ /POSSIBLE BREAK-IN ATTEMPT/
    ip = line.split
    to_block =  ip[11].delete('[]') 
    block = `iptables -A INPUT -s #{to_block} -j DROP` 
    end
end
