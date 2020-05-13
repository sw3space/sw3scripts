#!/bin/bash

INFNAME=$1

function failover_bond_interface() {
	cat /proc/net/vlan/config > /tmp/bondvconfig
	if grep -q bond /tmp/bondvconfig ;then
		for i in `cat /sys/class/net/bonding_masters`;do
			echo ifenslave -c $i $INFNAME
		done
	else
		for i in `cat /sys/class/net/bonding_masters`;do
			if [ $i != "bond0" ];then
			for x in `cat /proc/net/vlan/config | grep $INFNAME |awk '{print $1}'`;do
				echo ifenslave -c $i $x
			done
			fi
		done
	fi
# failover_bond_interface
}

failover_bond_interface