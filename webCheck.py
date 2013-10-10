#!/usr/bin/python

import http.client, sys
from optparse import OptionParser

usageString = "Usage: %prog [options] hostname"
parser = OptionParser(usage=usageString)
parser.add_option("-p", "--port", dest="port", metavar="PORT", default=80, type="int", help="Port to connect to")

(opts,args) = parser.parse_args()

if len(args) < 1:
  parser.error("Hostname is requiered")

host = args[0]
port = args[1]

client = http.client.HTTPConnection(host,port)
client.request("GET","/")
resp = client.getresponse()
client.close()

if resp.status == 200:
  print(host + " : OK")
  sys.exit()

print(host + " : DOWN! (" + resp.status + " ," + resp.reason + ")")
