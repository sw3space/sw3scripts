#!/bin/bash

function generate_all_inf_lldp() {
	for INFNAME in `ls /sys/class/net/ |grep -v -E "lo|bond|br|tap|vxlan|gre|mido|meta"|grep -v '\.'`;do
		lstate=`cat /sys/class/net/$INFNAME/operstate`
		if [ "$lstate" == "up" ];then
			/usr/sbin/lldpctl $INFNAME > $INFNAME.lldp
			cat $INFNAME.lldp |grep -E "SysName|PortID" |awk 'NR%2{printf "%s ",$0;next;}1' |sed 's/\<ifname\>//g'|awk '{$1=$1};1' > $INFNAME.lldp.short.t
			echo "Interface: $INFNAME" `cat $INFNAME.lldp.short.t` > $INFNAME.lldp.short
			rm $INFNAME.lldp.short.t
		fi
	done
# generate_all_inf_lldp
}
generate_all_inf_lldp