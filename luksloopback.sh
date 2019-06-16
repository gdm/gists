#!/bin/bash -xe

loopdevice=/dev/loop0
loopfile=/root/crypt.loop

#megabytes
loopsize=256

#/dev/mapper/xxxxx when open
cryptmapper=crypt

makefilesystem=ext4

#mountpoint of uncrypted device
mountpoint=/opt/crypt


#creates a new file
create() {
  if [ -e $loopfile ]; then
    echo "File $loopfile exist, do nothing"
    exit 2
  else
  echo creating a file with size ${loopsize}M with zero bits.. this could take a while..
  dd if=/dev/zero of=$loopfile bs=1M count=$loopsize
  losetup $loopdevice $loopfile
  cryptsetup luksFormat -y $loopdevice
  cryptsetup open $loopdevice $cryptmapper
  sudo mkfs.$makefilesystem /dev/mapper/$cryptmapper
  cryptsetup close $cryptmapper
  losetup -d $loopdevice
  losetup -a
  fi
}

#mounts crypted loopback file
open() {
  if mount | grep /dev/mapper/$cryptmapper >& /dev/null; then
    echo "/dev/mapper/$cryptmapper already mounted, do nothing"
    exit 1
  else
    losetup $loopdevice $loopfile
    cryptsetup open $loopdevice $cryptmapper
    mkdir -p $mountpoint
    mount /dev/mapper/$cryptmapper $mountpoint
  fi
}

#unmounts previously mounted loopback file
close() {
  umount $mountpoint
  cryptsetup close $cryptmapper
  losetup -d $loopdevice
}

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


echo loopdevice  $loopdevice
echo loopfile    $loopfile
echo loopsize    $loopsize
echo cryptmapper $cryptmapper
echo filesystem  $makefilesystem
echo mountpoint  $mountpoint
echo command     $1

$1
