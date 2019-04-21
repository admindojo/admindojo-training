---
id: storage-raid-create-lvl1-ub18
title: Create a level 1 raid from empty disks
---

Create a level 1 raid from empty disks


Training ID: *storage-raid-create-lvl1-ub18*

## Scenario

Your customer got a new Ubuntu 18 Server with two additional disks. The customer needs a new directory at `\data` to store important files. 

All data inside this directory should be stored on a RAID 1 utilizing the additional disks. Your colleagues are familiar with RAID but want to try Btrfs as filesystem.
But, in case they don't like Btrfs, they only want to convert the filesystem without changing the RAID.

## Objectives

- identify the two additional disks
- create a software RAID 1
- format and mount the RAID according to your instructions
- make sure the mount persists across reboots

## Notes

- After you reboot your VM you need to run `vagrant reload --no-provision` inside the training directory to [mount required directories](https://github.com/hashicorp/vagrant/issues/1845)
- In case your VM doesn't boot anymore or the HDDs are broken just run `vagrant destroy` followed by `vagrant up` to delete the VM and start over.


## Detailed explanation (spoilers)

### partitioning

<details><summary>click to show</summary>
<p>

Disks are organized in partitions. Partitions than have a filesystem that is used to store the files.
While it is possible to create a [RAID of whole disks](https://raid.wiki.kernel.org/index.php/Partition_Types), there is no 100% right answer whether to [use whole disks or partitions](https://unix.stackexchange.com/questions/320103/whats-the-difference-between-creating-mdadm-array-using-partitions-or-the-whole). 
For this training, we'll go with partitions. By using partitions we're able to precisely specifying the size to 1000MB each. 

To list all available disks, [fdisk](https://manpages.ubuntu.com/manpages/xenial/en/man8/fdisk.8.html) can be used.
Since everything in Linux is a file, disks have a path too. Once you know the path of both disk, you can use [cfdisk](https://manpages.ubuntu.com/manpages/xenial/en/man8/cfdisk.8.html) to create a partition.

While fdisk can be used for partitioning as well, cfdisk provides a simple graphical interface.

</p>


### filesystem: btrfs

<details><summary>click to show</summary>
<p>

btrfs is a modern filesystem for Linux that implements advanced features like:

- Snapshots
- Checksums
- Integrated multi-device spanning(RAID like features)
- Compression
- Deduplication

While Brtfs provides these advanced features, it's development status is heavily discussed inside the community. Because some of its features are
still not ready for production its still not the default filesystem on Linux distributions. [openSUSE](https://en.opensuse.org/SDB:BTRFS) is one of the few that comes with Btrfs by default.
RedHat [publicly announced](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/7.4_Release_Notes/chap-Red_Hat_Enterprise_Linux-7.4_Release_Notes-Deprecated_Functionality.html) the removal of Brtfs support 2017

Despite the development status of some features, Btrfs is sill used by many.
As long as the sysadmin is aware of the [known issues](https://wiki.debian.org/Btrfs#Warnings), the functional features outweigh the disadvantages of older filesystems like ext4. 

Using Brtfs with RAID is an example of these known issues and shows why it's important to check the [Btrfs Statuspage](https://btrfs.wiki.kernel.org/index.php/Status). Even though Btfs is capable of setting up a RAID itself - the implementation is not fully developed. 
By checking the [Statuspage](https://btrfs.wiki.kernel.org/index.php/Status), you'll find RAID0, RAID1 and RAID10 marked as stable and RAID56 as unstable. Futher reading of the page also reveals "reading from mirrors in parallel can be optimized further".

One strategy to use Btrfs but avoid any issues of its RAID-feature is to not use the build-in RAID capability and relay on stable implementations like mdadm. 
This strategy is also used in this training.


Creating a btrfs filesystem is pretty easy: [mkfs.btrfs](https://btrfs.wiki.kernel.org/index.php/Manpage/mkfs.btrfs)

`mkfs` was originally implemented 40 years ago and is still used for many filesystems in Linux. Running `mkfs.<fs-type>` supports most filesystems.

External resources
- [Btrfs Wiki - kernel.org](https://btrfs.wiki.kernel.org/index.php/Main_Page)
- [Brtfs Wiki - debian.org](https://wiki.debian.org/Btrfs)
- [Companies that use Btrfs in production](https://btrfs.wiki.kernel.org/index.php/Production_Users)
- [List of Btrfs features including development status](https://btrfs.wiki.kernel.org/index.php/Status)

</p>
</details>

### fstab


<details><summary>click to show</summary>
<p>

To quote [fstab(5)](http://man7.org/linux/man-pages/man5/fstab.5.html):

> The file fstab contains descriptive information about the filesystems
       the system can mount.

> [...] it is the duty of the system administrator to properly
       create and maintain this file. [...]

While modern distributions also allow dynamic mounting via [autofs](https://wiki.archlinux.org/index.php/autofs) or [systemd](https://www.freedesktop.org/software/systemd/man/systemd.automount.html), `\etc\fstab` is still the main source for permanent storage devices.

Adding mounts is pretty straight forward. Remember to use the UUID to identify partitions and use [blkid](https://linux.die.net/man/8/blkid) to get all informations needed.

It is worth to check out all available `options` in [mount(8)](https://manpages.ubuntu.com/manpages/cosmic/en/man8/mount.8.html). It is always good to lookup options when copying from tutorials or other posts.
Usually adding only `defaults` is fine(note that defaults are always included by default even if you don't add it. It's only needed because the options field can't be empty).

*/etc/fstab.d/?*

fstab.d is woth to talk about. Usually it's good practice to put additional configuration files in separate x*.d* directories in case they exist.
But even though a /etc/fstab.d/ directory can exist, a websearch shows that it's not 100% save to use. The main reasons are:

- /etc/fstab has a long history and other tools may only check this file for mounts
- typically the file only contains a handful of entries
- systemd provides a modern way to systematically configure many mounts

Check out this interesting discussion by developers of systemd, mound and libremount: [/etc/fstab.d yes or not](https://lists.gt.net/linux/kernel/1480405)

> And we don't want to support that in systemd. [...]
> The gain of features from fstab.d/ vs. the amount of breakage it 
causes is not worth the trouble. 

So, since the content of /etc/fstab is vital for your system, you probably should just use the good old /etc/fstab file. 

External resources
- [autofs](https://wiki.archlinux.org/index.php/autofs)
- [systemd.automount](https://www.freedesktop.org/software/systemd/man/systemd.automount.html)
- [Anatomy of the Linux file system](https://www.ibm.com/developerworks/linux/library/l-linux-filesystem/)

</p>
</details>


### mdadm

<details><summary>click to show</summary>
<p>

Creating a software RAID with mdadm is pretty straight forward. The command needed for this training is even included in the [mdadm man page](https://linux.die.net/man/8/mdadm).

Be aware that a RAID can prevent data loss - but fixing a broken RAID can be complex.
This training only requires you to create a RAID, but you should explore the tools to analyse and monitor your RAID yourself.


External resources
- [mdadm(8) - Linux man page](https://linux.die.net/man/8/mdadm)
- [Linux Raid Wiki](https://raid.wiki.kernel.org)
- [Linux Raid Wiki - A guide to mdadm](https://raid.wiki.kernel.org/index.php/A_guide_to_mdadm)
- [Tips on RAID/mdadm maintainance](https://raid.wiki.kernel.org/index.php/Detecting,_querying_and_testing)

</p>
</details>
