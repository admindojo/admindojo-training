<div class="jumbotron">
    <h1 class="display-4 text-left">system-packages-usage-1-ub18</h1>
    <p class="lead text-left">Learn basic package operations on Debian-based distributions</p>
</div>


# *THIS FILE IS THE PUBLIC TRAINING DESCRIPTION* (remove this line)
# *USE THIS FILE AS TEMPLATE. PLEASE FOLLOW THE SAME STUCTURE* (remove this line)

<h2 class="display-4">Objectives</h2>

- setup a apache web server with default configuration
- serve a website that contains `Hello World!`as landing-page (plaintext, no need for HTML).
- make your website accessible via SSL (a simple selfsigned-snakeoil cert is ok)

<h2 class="display-4">Notes</h2>

- Please reboot your VM via `vagrant reload` inside the training directory - not `reboot` -  to [mount required directories](https://github.com/hashicorp/vagrant/issues/1845)
- ..

<h2 class="display-4">Walkthrough</h2>

??? lead "add sub-topic here"

    <div class="alert alert-secondary" role="alert">

    Disks are organized in partitions. Partitions than have a filesystem that is used to store the files.
    
    While it is possible to create a [RAID of whole disks](https://raid.wiki.kernel.org/index.php/Partition_Types), there is no 100% right answer whether to [use whole disks or partitions](https://unix.stackexchange.com/questions/320103/whats-the-difference-between-creating-mdadm-array-using-partitions-or-the-whole). 
    For this training, we'll go with partitions. By using partitions we're able to precisely specifying the size to 1000MB each. 
    
    To list all available disks, [fdisk](https://manpages.ubuntu.com/manpages/xenial/en/man8/fdisk.8.html) can be used.
    Since everything in Linux is a file, disks have a path too. Once you know the path of both disk, you can use [cfdisk](https://manpages.ubuntu.com/manpages/xenial/en/man8/cfdisk.8.html) to create a partition.
    
    While fdisk can be used for partitioning as well, cfdisk provides a simple graphical interface.
    
    </div>
    
??? lead "add sub-topic here"
    
    <div class="alert alert-secondary" role="alert">

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
    By checking the [Statuspage](https://btrfs.wiki.kernel.org/index.php/Status), you'll find RAID0, RAID1 and RAID10 marked as stable and RAID56 as unstable. Futher reading reveals the sidenote "reading from mirrors in parallel can be optimized further".
    
    One strategy to use Btrfs but avoid any issues of its RAID-feature is to not use the build-in RAID capability and relay on stable implementations like mdadm. 
    This strategy is also used in this training.
    
    
    Creating a btrfs filesystem is pretty easy: [mkfs.btrfs](https://btrfs.wiki.kernel.org/index.php/Manpage/mkfs.btrfs)
    
    `mkfs` was originally implemented 40 years ago and is still used for many filesystems in Linux. Running `mkfs.<fs-type>` supports most filesystems.
    
    External resources
    
    - [Btrfs Wiki - kernel.org](https://btrfs.wiki.kernel.org/index.php/Main_Page)
    - [Brtfs Wiki - debian.org](https://wiki.debian.org/Btrfs)
    - [Companies that use Btrfs in production](https://btrfs.wiki.kernel.org/index.php/Production_Users)
    - [List of Btrfs features including development status](https://btrfs.wiki.kernel.org/index.php/Status)
    
    </div>
