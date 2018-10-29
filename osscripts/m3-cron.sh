#!/bin/bash

tday=`date +%Y-%m-%d-%H-%M`

openstack server list --project bf8fa08c1eb5415aa9530676ce384339 --long -c ID -c Host -c Name -c Status > /home/saung/workspace/tmp/m3/cron/monarch-vm-hw-mapping-$tday.txt
openstack server list --project d999492ca4a74db6b96bbb85fe072894 --long -c ID -c Host -c Name -c Status > /home/saung/workspace/tmp/m3/cron/m3-vm-hw-mapping-$tday.txt
##/usr/bin/dsh -c -g m3compute 'uname -a' |sort > /home/saung/workspace/tmp/m3/cron/m3-hypervisors-uname-$tday.txt
#/usr/bin/dsh -c -g m2compute.mcc 'uname -a' |sort > /home/saung/workspace/tmp/m3/cron/monarch-hypervisors-uname-$tday.txt

scp /home/saung/workspace/tmp/m3/cron/*$tday.txt m3.massive.org.au:/projects/pMOSP/hypervisor/

##echo Host,Model,Serial,Bios,NCPU,Memory,Mlx,GPU,p1p1,p1p2,HTT,CPUFreq,PowerProfile,Ubuntu,Kernel,Ofed,MlxFirmware,QEMU,Libvirt > /home/saung/workspace/tmp/m3/cron/m3-hardware-status-$tday.csv
#/usr/bin/dsh -c -g m3compute 'sudo /home/saung/check-hardware.sh' |sort >> /home/saung/workspace/tmp/m3/cron/m3-hardware-status-$tday.csv
