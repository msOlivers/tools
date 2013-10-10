#!/usr/bin/env ruby
# By Cfernandez rek2gnulinux@gmail.com
# gem install daemons
require 'daemons'

Daemons.run('/usr/bin/monitor.rb')
