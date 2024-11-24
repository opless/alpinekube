echo "do not run this, read it."
exit 1

# assuming you have a disk prepped by, say quick-and-nasty-lvm.sh
# this will somewhat help

mkdir -p /opt/storage/
echo '/dev/vg_sdb/sdbvol /opt/storage ext4 rw,relatime 0 1' >> /etc/fstab 
mount -a
mkdir -p /opt/storage/longhorn
