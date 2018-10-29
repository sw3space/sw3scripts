#!/bin/bash

echo $1
#nova list --all-tenants --host $1 --fields OS-EXT-SRV-ATTR:host,name,id,user_id,tenant_id,status|awk -F"|" '{print $2","$3","$4","$5","$6","$7}' |grep -v "OS-EXT-SRV-ATTR" |grep -v ",,,,"
nova list --all-tenants --host $1 --fields OS-EXT-SRV-ATTR:host,name,id,user_id,tenant_id,status
