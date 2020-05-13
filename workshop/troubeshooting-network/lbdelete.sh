#!/bin/bash

set -x

: ${LBNAME:=lb2}
: ${LISTENERNAME:=listener2}
: ${POOLNAME:=pool2}

# Run this as the admin user
. openrc

check_lb() {
  while true; do
    if openstack loadbalancer show ${LBID} --column provisioning_status --format value | grep --quiet ACTIVE; then
      break
    fi
    sleep 10
  done
}
LBID=$(openstack loadbalancer list --column name --column id --format value | grep lb2 | awk '{print $1}')

# Delete loadbalancer
openstack loadbalancer member delete ${POOLNAME} 192.168.74.7
check_lb

openstack loadbalancer member delete ${POOLNAME} 192.168.74.9
check_lb

openstack loadbalancer pool delete  ${POOLNAME}
check_lb

openstack loadbalancer listener delete ${LISTENERNAME}
check_lb

openstack loadbalancer delete ${LBNAME}
