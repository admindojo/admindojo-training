#!/usr/bin/env bash
apt-get  update
apt-get -y install mdadm parted
mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/sdc /dev/sdd
mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
echo '/dev/md0 /mnt/md0 ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab