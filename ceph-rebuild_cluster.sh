rm -f ceph*
ceph-deploy purge cb1 cb2 cb3 cb4
ssh root@cb1 'umount /var/lib/ceph/osd/*;rm -rf /var/lib/ceph'
ssh root@cb2 'umount /var/lib/ceph/osd/*;rm -rf /var/lib/ceph'
ssh root@cb3 'umount /var/lib/ceph/osd/*;rm -rf /var/lib/ceph'
ssh root@cb4 'umount /var/lib/ceph/osd/*;rm -rf /var/lib/ceph'
ceph-deploy install --release jewel cb1 cb2 cb3 cb4
ceph-deploy new cb1
ceph-deploy disk zap cb1:/dev/xvdb cb2:/dev/xvdb cb3:/dev/xvdb cb4:/dev/xvdb
#ssh root@cb2 'reboot'
#ssh root@cb3 'reboot'
#ssh root@cb4 'reboot'
echo 'enable experimental unrecoverable data corrupting features = *' >> ceph.conf
ceph-deploy mon create cb1
ceph-deploy mon create-initial
ceph-deploy osd create --bluestore cb1:/dev/xvdb cb2:/dev/xvdb cb3:/dev/xvdb cb4:/dev/xvdb
ceph osd pool set rbd size 2
ceph osd pool set rbd min_size 1