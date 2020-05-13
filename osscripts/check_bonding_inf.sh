#!/bin/bash

function check_bonding_inf() {
	for i in `cat /sys/class/net/bonding_masters`;do
		echo "$i" `cat /proc/net/bonding/$i |grep "Currently Active Slave" |awk -F": " '{print $2}'`
	done
# check_bonding_inf
}

check_bonding_inf