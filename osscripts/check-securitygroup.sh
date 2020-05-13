#!/bin/bash

#for i in `nova list-secgroup $1 | grep -vE '(Id|\+)' | awk '{print $2}'`;do echo Securty Group ID: $i;openstack security group rule list $i --long;done
for i in `nova list-secgroup $1 |grep -vE '(Id|\+)' | awk '{print $2","$4}'`;do sec_group=$(echo $i);echo "";echo Security Group: $sec_group;openstack security group rule list $(echo $i|awk -F"," '{print $1}') --long;done 
