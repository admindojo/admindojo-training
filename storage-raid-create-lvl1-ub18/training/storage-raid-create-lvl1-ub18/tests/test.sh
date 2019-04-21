#!/usr/bin/env bash
apt-get  update
apt-get -y install mdadm
yes | mdadm --create  --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdc1 /dev/sdd1
mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
mkfs.btrfs /dev/md0
mkdir /data
UUID=$(blkid  | grep md0 | cut -d '"' -f2); echo "UUID=$UUID /data btrfs defaults 0 0" | sudo tee -a /etc/fstab
update-initramfs -u
