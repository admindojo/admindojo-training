#!/usr/bin/env bash
# install inspec
apt update
apt install -y ruby
curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec

# remove banner
rm /etc/update-motd.d/50-motd-news
rm /etc/update-motd.d/80-livepatch
rm /etc/update-motd.d/51-cloudguest
rm /etc/update-motd.d/80-esm
rm /etc/update-motd.d/95-hwe-eol
rm /etc/update-motd.d/91-release-upgrade

# add inspec alias
echo "alias admindojo=\"inspec exec /vagrant/training/ --reporter cli\"" >> /home/vagrant/.bashrc