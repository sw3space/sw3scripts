#!/bin/bash

for i in `nova list-secgroup $1 | grep -vE '(Id|\+)' | awk '{print $2}'`;do echo Securty Group ID: $i;openstack security group rule list $i --long;done
