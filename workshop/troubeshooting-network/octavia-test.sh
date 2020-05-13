#!/bin/bash

set -x

. octavia-openrc

# Security groups:
# 59f03fc5-dbbe-48cf-b586-d037c42f0a21 (octavia_sec_grp)
# dd7dac7f-cea8-4ce7-a158-9fc47278f259 (default)
# 7962d2f7-06d3-41e0-b326-372834eb3e48 (ping/ssh)

# Images:
# d8572dc5-eecd-45ae-92c4-0f9a5d08201e (amphora-x64-haproxy-SUSE)
# dbe33a7c-fabb-462f-a41d-63539ef0546a (amphora-x64-haproxy-aio)

openstack server create \
  --flavor d1735747-44dd-4796-84f0-4ec4dba1cc39 \
  --network lbaas-mgmt \
  --security-group 59f03fc5-dbbe-48cf-b586-d037c42f0a21 \
  --image d8572dc5-eecd-45ae-92c4-0f9a5d08201e \
  --key-name workshop \
  test-octavia
