---
id: storage-raid-create-lvl1-ub18
title: Create a level 1 raid from empty disks
---

Create a level 1 raid from empty disks


Training ID: *storage-raid-create-lvl1-ub18*

## Scenario

Your customer got a new Ubuntu 18 Server with two additional disks. The customer needs a new directory at `\data` to store important files. 

All data inside this directory should be stored on a RAID 1 utilizing the additional disks. Your companys policy is to use Btrfs as the default filesystem.

## Objectives

- identify the two additional disks
- create a software RAID 1
- format and mount the RAID according to your instructions
- make sure the mount persists accros reboots
