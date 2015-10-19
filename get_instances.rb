#!/usr/bin/ruby  
 
# RUN 'locate ec2.rb' AND CHANGE THE FOLLOWING PATH ACCORDINGLY  
#load '/usr/lib/ruby/gems/2.1.0/gems/aws-sdk-1.33.0/lib/aws/ec2.rb'  
#load '/usr/lib/ruby/gems/2.2.0/gems/aws-sdk-1.33.0/lib/aws/ec2.rb'
# this ruby script will list all instances, show their tag and private/public IP 
# create a file with the results with aliases
# add a line to .bashrc to source this file
# this way even when IP's change on hosts we always have the aliases updated for ssh logins.
# the script expects for the username to be the same locally than in the server
# if different, just add the remote username@ in the related line below.


# Feb-Amazon AWS upgraded their sdk to v2+ as default so this code only runs on
# v1 so I had to do some research and downgrade my gem etc.. :/
require 'aws-sdk-v1'
require 'colorize'


def output(profiles)
  profiles.each do |creds|
    provider = AWS::Core::CredentialProviders::SharedCredentialFileProvider.new( profile_name: "#{creds}")
    ec2 = AWS::EC2.new(credential_provider: provider)
    instances = ec2.instances

    instances.each { |e|   
      tags = e.tags  
      id = e.id  
      unless e.ip_address.nil?   
        ip = e.ip_address  
      else  
        ip = ' '  
      end  
      unless tags['Name'].nil?   
        name = tags['Name']  
      else  
        name = ' '  
      end  
      unless e.private_ip_address.nil?  
        pip = e.private_ip_address  
      else  
        pip = ' '  
      end
      puts '| ' + id.red + ' | ' + pip.ljust(15).yellow + ' | ' + ip.ljust(15).light_blue + ' | ' + name.ljust(34).green + ' |'
 
      unless tags['Name'].nil?
        #clean name variable later on
        File.open(ENV['HOME']+'/.hostnames', 'a+') do | file |
          clean_name=name[/(\S+)/, 1]
          file.puts("alias #{clean_name}='ssh #{pip}'")
        file.close
        end
      end
      }
    end
end 

# create the array with our AWS profiles..
# profiles create with aws --configure and should reside under ~/.aws/
profiles = ['production','development']

# starts by checking for this file and removing it.
# so we can start a create a new one..
 if File.exist?(ENV['HOME']+'/.hostnames')
   File.delete(ENV['HOME']+'/.hostnames')
 end


# Print the header
 puts '| Id         | Private IP      | Elastic IP      | Name                               |'.yellow.on_blue.underline

#we can our method.. we add this in a method so we do not have to repeat code on each profile.
output(profiles)


# here we check to see if our bashrc includes the hostnames file..and adds it if it does not.
unless File.read(ENV['HOME']+'/.bashrc').include?(ENV['HOME']+'/.hostnames')
  File.open(ENV['HOME']+'/.bashrc', 'a+') do | bashrc |
    bashrc.puts('source '+ENV['HOME']+'/.hostnames')
    bashrc.close
  end
end
