#!/bin/sh
export LFS=/mnt/lfs

sudo mkdir /media/kant/local #This creates directory, once created you can remove this command freely. REPLACE '/kant' with your username
#EXAMPLE 'mkdir /media/user/local'

sudo mount /dev/sda5 /media/kant/local  #This mount the real hard drive partition on above directory. REPLACE 'sda5' with your partition.
#EXAMPLE 'mount /dev/xxxx /media/username/local'

sudo rmmod nbd; sudo modprobe nbd max_part=16 #This loads nbd module

sudo rmmod nbd; sudo modprobe nbd max_part=16 #This loads nbd module again, if any error happened. DON'T REMOVE THIS

sudo qemu-nbd -c /dev/nbd0 /media/kant/local/Linux/hdd.vhdx #This loads your VHDX drive on the nbd Block Device, if you have changed 'username' then
#EXAMPLE 'qemu-nbd -c /dev/nbd0 /media/usename/local/path/hdd.vhdx' [PATH is your directory in which VHDX is stored]

echo waiting for nbd block to load properly ... #Just to facilate sleep

sleep 1s #This prevent the execution of furthur commands, so that nbd block can load properly.

echo block loaded properly, executing...

sudo mkdir $LFS #It creates a directory /mnt/lfs. Once creatred you can remove this line

sudo mount -v -t ext4 /dev/nbd0p1 $LFS #Mounts root partition on /mnt/lfs. CHANGE 'NBD' accordingly.

sudo mkdir $LFS/home #It creates a directory /mnt/lfs/home. Once creatred you can remove this line. 

sudo mount -v -t ext4 /dev/nbd0p2 /mnt/lfs/home #Mounts boot partition on /mnt/lfs/home. CHANGE 'NBD' accordingly.

sudo mkdir $LFS/boot #It creates a directory /mnt/lfs/boot. Once creatred you can remove this line

sudo mount -v -t ext2 /dev/nbd0p4 $LFS/boot  #Mounts root partition on /mnt/lfs/boot. CHANGE 'NBD' accordingly.

sudo /sbin/swapon -v /dev/nbd0p3 #It activates swap partition

echo create LFS variable again, shell has ended
echo Mouting work done
