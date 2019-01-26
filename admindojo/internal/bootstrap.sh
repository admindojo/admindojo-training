#!/usr/bin/env bash

apt update

# make sure basic requirements are installed
apt install -y -q --no-install-recommends git

# install inspec
apt install -y --no-install-recommends ruby
curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec

# install tuptime for detailed uptime
cd /tmp
git clone https://github.com/rfrail3/tuptime.git
cd tuptime
bash tuptime-install.sh

# remove banner
rm /etc/update-motd.d/50-motd-news
rm /etc/update-motd.d/80-livepatch
rm /etc/update-motd.d/51-cloudguest
rm /etc/update-motd.d/80-esm
rm /etc/update-motd.d/95-hwe-eol
rm /etc/update-motd.d/91-release-upgrade
rm /etc/update-motd.d/10-help-text

# install admindojo
apt install -y python3-pip
python3 -m pip install admindojo
## add admindojo to path
echo 'PATH=$PATH:/home/vagrant/.local/bin/'>>/home/vagrant/.bashrc