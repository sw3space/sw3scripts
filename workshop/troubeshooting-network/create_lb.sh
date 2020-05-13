   11  2018-10-23 11:41:47 openstack --os-cloud octavia loadbalancer list
   12  2018-10-23 11:49:12 openstack --os-cloud demo loadbalancer create --name lb1 --vip-subnet-id public-subnet
   13  2018-10-23 11:49:25 openstack --os-cloud admin loadbalancer create --name lb1 --vip-subnet-id public-subnet
   15  2018-10-23 11:49:49 openstack loadbalancer list
   34  2018-10-23 12:07:00 openstack loadbalancer list
   35  2018-10-23 12:07:09 openstack loadbalancer delete lb1
   36  2018-10-23 12:07:18 openstack loadbalancer list
   37  2018-10-23 12:07:36 openstack --os-cloud admin loadbalancer create --name lb1 --vip-subnet-id public-subnet
openstack loadbalancer create --name lb1 --vip-subnet-id private-subnet
openstack loadbalancer list
openstack loadbalancer listener create  --name listener1 --protocol-port 80 --protocol HTTP lb1
openstack loadbalancer list
openstack loadbalancer show lb1
openstack loadbalancer pool create --name pool1 --protocol HTTP --lb-algorithm ROUND_ROBIN --listener listener1
openstack loadbalancer list
openstack loadbalancer member create --subnet-id f8fc384c-cc4e-4940-8a90-93e0a66207ab --protocol-port 80 --address 192.168
.74.6 pool1
openstack loadbalancer member create --subnet-id f8fc384c-cc4e-4940-8a90-93e0a66207ab --protocol-port 80 --address 192.168
.74.3 pool1
