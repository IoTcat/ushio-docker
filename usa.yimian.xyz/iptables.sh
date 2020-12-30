#!/bin/bash
iptables -F
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
# ssh
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
# iis
#iptables -A INPUT -p tcp --dport 80 -j ACCEPT
#iptables -A FORWARD -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -p tcp --dport 443 -j ACCEPT
#iptables -A FORWARD -p tcp --dport 443 -j ACCEPT
#redrange
iptables -A INPUT -p tcp --dport 90 -j ACCEPT
# frps
#iptables -A FORWARD -p tcp --dport 4477 -j ACCEPT
#iptables -A FORWARD -p tcp --dport 4480 -j ACCEPT
#iptables -A FORWARD -p tcp --dport 4443 -j ACCEPT
#iptables -A FORWARD -p tcp --dport 4400:4440 -j ACCEPT
# dns
#iptables -A INPUT -p tcp --sport 53 -j ACCEPT
#iptables -A INPUT -p udp --sport 53 -j ACCEPT
# docker proxy
iptables -A INPUT -s 114.116.85.132 -j ACCEPT
iptables -A INPUT -s 127.0.0.1 -j ACCEPT
iptables -A INPUT -s 80.251.216.25 -j ACCEPT
# for established service
iptables -A INPUT -p tcp -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp -m state --state RELATED,ESTABLISHED -j ACCEPT
# icmp ping
iptables -A INPUT -p icmp -j ACCEPT
# dns lookup
iptables -A INPUT -i lo -j ACCEPT
#iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
# anti muma
iptables -A OUTPUT -p tcp --sport 31337 -j DROP
iptables -A OUTPUT -p tcp --dport 31337 -j DROP
# anti ddos
#iptables -A FORWARD -f -m limit --limit 100/s --limit-burst 100 -j ACCEPT
iptables -A INPUT -p icmp -m limit --limit 1/s --limit-burst 10 -j ACCEPT
# end
#iptables -A FORWARD -j DROP
# save
service iptables save
echo Please restart docker
#systemctl restart iptables
