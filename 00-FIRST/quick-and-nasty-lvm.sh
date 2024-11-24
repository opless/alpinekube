# Just to remind you

#pvcreate /dev/sdb
#pvdisplay /dev/sdb
#vgcreate vg_sdb /dev/sdb
#vgdisplay vg_sdb
#lvcreate -l 100%FREE -n sdbvol vg_sdb
#lvdisplay /dev/vg_sdb/sdbvol

#mkfs.ext4 /dev/vg_sdb/sdbvol 
