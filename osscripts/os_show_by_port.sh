#!/bin/bash

vmid=`openstack port show $1 -f value -c device_id`;openstack server show $vmid
