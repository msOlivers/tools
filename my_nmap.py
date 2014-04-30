#!/usr/bin/env python3
# Christian Fernandez just playing around with python and nmap module
# sudo pip install nmap
# arch linux yaourt python-pip to install python modules

import nmap
import socket
import optparse

def nmapScan(tgtHost, tgtPort):
    nmScan = nmap.PortScanner()
    nmScan.scan(tgtHost, tgtPort)
    state = nmScan[tgtHost]['tcp'][int(tgtPort)]['state']
    print("[*] " + tgtHost + " tcp/"+tgtPort +" "+state)


def main():

    parser = optparse.OptionParser("usage %prog -H" + " <target host> -p <target port>")
    parser.add_option('-H', dest='tgtHost', type='string', help='specify target host')
    parser.add_option('-p', dest='tgtPort', type='string', help='specify target port')
    (options, args) = parser.parse_args()
    tgtHost = options.tgtHost
    tgtPorts = str(options.tgtPort).split(',')
    if (tgtHost == None) | (tgtPorts == None):
        print(parser.usage)
        exit(0)
    if socket.gethostbyname(tgtHost) != tgtHost:
        tgtHost = socket.gethostbyname(tgtHost)
    for tgtPort in tgtPorts:
        nmapScan(tgtHost, tgtPort)

if __name__ == '__main__':
    main()
