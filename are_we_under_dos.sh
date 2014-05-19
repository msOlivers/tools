netstat -n -p|grep SYN_REC | wc -l


netstat -n -p | grep SYN_REC | sort -u


#list ips attacking.
netstat -n -p | grep SYN_REC | awk '{print $5}' | awk -F: '{print $1}'

#unique ip's
netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n


#Use netstat command to calculate and count the number of connections each IP address makes to the server.

netstat -anp |grep 'tcp|udp' | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n

#List count of number of connections the IPs are connected to the server using TCP or UDP protocol.

netstat -ntu | grep ESTAB | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr

#Check on ESTABLISHED connections instead of all connections, and displays the connections count for each IP.

netstat -plan|grep :80|awk {'print $5'}|cut -d: -f 1|sort|uniq -c|sort -nk 1

#Show and list IP address and its connection count that connect to port 80 on the server. Port 80 is used mainly by HTTP web page request.


#fast and durty mitigation

iptables -A INPUT 1 -s $IPADRESS -j DROP/REJECT


killall -KILL httpd
 
service httpd start           #For Red Hat systems 
/etc/init/d/apache2 restart   #For Debian systems
