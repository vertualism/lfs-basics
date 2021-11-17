mkdir /media/kant/local
mount /dev/sda5 /media/kant/local
rmmod nbd; modprobe nbd max_part=16
rmmod nbd; modprobe nbd max_part=16
qemu-nbd -c /dev/nbd0 /media/kant/local/Linux/hdd.vhdx
export LFS=/mnt/lfs
mount -v -t ext4 /dev/nbd0p1 $LFS
mount -v -t ext4 /dev/nbd0p2 /mnt/lfs/home
mount -v -t ext2 /dev/nbd0p4 $LFS/boot
/sbin/swapon -v /dev/nbd0p3
cd /
