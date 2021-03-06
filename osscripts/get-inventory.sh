#/bin/bash
# 20200901
# sw3
ncpu=$(lscpu |grep -w "CPU(s):" |grep -v NUMA|awk '{print $2}')
ntpc=$(lscpu |grep "Thread(s) per core"|awk -F":  " '{print $2}')
ncore=$(expr $ncpu / $ntpc)

nicspeed=$(ethtool p1p1 |grep "Speed:" |awk -F": " '{print $2}')
collectnicinfo=$(lshw -c network |grep -B1 Mellanox|sort -u > /tmp/`hostname`.nic)
nicmodel=$(cat /tmp/`hostname`.nic|grep -B1 Mellanox |grep product |awk '{print $4}'|sed 's/[][]//g')

collectgpuinfo=$(lshw -c display |grep -B1 NVIDIA |grep -v Audio |grep product > /tmp/`hostname`.gpu)
ngpu=$(cat /tmp/`hostname`.gpu|wc -l)

detectmulti=$(cat /tmp/`hostname`.gpu|sort -u |wc -l)
if [ $detectmulti -ge "1" ];then
	gpumodel=$(cat /tmp/`hostname`.gpu |awk '{print $3 $4}'|sort -u|sed 's/[][]//g'|tr '\n' ':')
fi

if [ $detectmulti -lt "1" ];then gpumodel="NOGPU";fi

collectsysinfo=$(dmidecode -t system > /tmp/`hostname`.sysinfo)
sysmodel=$(dmidecode -s system-product-name)
sysmanufacturer=$(dmidecode -s system-manufacturer)
systemserial=$(dmidecode -s system-serial-number)

meminfo=$(lsmem |grep "Total online memory" |awk -F":" '{print $2}'|sed 's/ //g')

vf_physicalinf=$(cat /usr/local/bin/enable-sriov-vf.sh |grep "vf_physicalinf="|awk -F"=" '{print $2}')

if [ -z "$vf_physicalinf" ];then statesriov=disable;
else
vlansriov=$(cat /usr/local/bin/enable-sriov-vf.sh |grep "vf_vlan="|awk -F"=" '{print $2}')
nsriov=$(cat /sys/class/net/$vf_physicalinf/device/sriov_numvfs)
statesriov="enable:$nsriov:$vlansriov"
fi

hname=$(hostname -s)
echo $sysmanufacturer"|"$sysmodel"|"$systemsserial"|"$ncore"[cores]""|"$ntpc"[thread/core]""|"$meminfo"[memory]""|"$ngpu"[gpu]""|"$gpumodel"|"$statesriov"[sriov]""|"$nicspeed"|"$n
icmodel > $hname.inventory
