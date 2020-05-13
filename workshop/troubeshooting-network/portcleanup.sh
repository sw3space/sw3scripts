#!/bin/bash

set -x

. openrc

read -a ports < <(openstack port list --column ID \
  --column Name --column Status --format value \
  | grep DOWN \
  | cut -d ' ' -f 1)

for p in "${ports[@]}"; do
  openstack port delete "${p}"
done
