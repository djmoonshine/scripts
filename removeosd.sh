#Before this is run  thease steps should be taken:
#Mark osd as out:
#ceph osd out 0
#Wait for remapping of data.
#ceph -w
#Stop osd on server:
#echo "Stopping osd"$1
#stop ceph-osd id=$1

echo "Removing osd number" $1
ceph osd crush remove osd.$1
ceph auth del osd.$1
ceph osd rm $1
