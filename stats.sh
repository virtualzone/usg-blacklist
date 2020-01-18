#!/bin/bash
real_list=`grep -B1 "Dynamic Threat List" /config/config.boot | head -n 1 | awk '{print $2}'`
num_items=`/sbin/ipset list $real_list | wc -l`
num_local_pkts=`sudo iptables -vL WAN_LOCAL | grep $real_list | head -n 1 | awk '{print $1}'`
num_in_pkts=`sudo iptables -vL WAN_IN | grep $real_list | head -n 1 | awk '{print $1}'`
num_out_pkts=`sudo iptables -vL WAN_OUT | grep $real_list | head -n 1 | awk '{print $1}'`
echo "IPv4 Stats:"
echo "==========="
echo "#Rules: $num_items"
echo "#WAN_LOCAL: $num_local_pkts"
echo "#WAN_IN: $num_in_pkts"
echo "#WAN_OUT: $num_out_pkts"

real_list=`grep -B1 "Dynamic Threat List IPv6" /config/config.boot | head -n 1 | awk '{print $2}'`
if [ $real_list != "" ]; then
    num_items=`/sbin/ipset list $real_list | wc -l`
    num_local_pkts=`sudo ip6tables -vL WANv6_LOCAL | grep $real_list | head -n 1 | awk '{print $1}'`
    num_in_pkts=`sudo ip6tables -vL WANv6_IN | grep $real_list | head -n 1 | awk '{print $1}'`
    num_out_pkts=`sudo ip6tables -vL WANv6_OUT | grep $real_list | head -n 1 | awk '{print $1}'`
    echo ""
    echo "IPv6 Stats:"
    echo "==========="
    echo "#Rules: $num_items"
    echo "#WAN_LOCAL: $num_local_pkts"
    echo "#WAN_IN: $num_in_pkts"
    echo "#WAN_OUT: $num_out_pkts"
fi