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

# Create new loadbalancer
LBID=$(openstack loadbalancer create --name ${LBNAME} --vip-subnet-id private-subnet | grep ' id ' | cut -d '|' -f 3)
check_lb

openstack loadbalancer listener create  --name ${LISTENERNAME} --protocol-port 80 --protocol HTTP ${LBNAME}
check_lb

openstack loadbalancer pool create --name ${POOLNAME} --protocol HTTP --lb-algorithm ROUND_ROBIN --listener ${LISTENERNAME}
check_lb

openstack loadbalancer member create --subnet-id f8fc384c-cc4e-4940-8a90-93e0a66207ab --protocol-port 80 --address 192.168.74.7 ${POOLNAME}
check_lb

openstack loadbalancer member create --subnet-id f8fc384c-cc4e-4940-8a90-93e0a66207ab --protocol-port 80 --address 192.168.74.9 ${POOLNAME}
check_lb
