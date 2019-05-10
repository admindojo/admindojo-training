#!/usr/bin/env bash

# allow password login
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentification no/PasswordAuthentification yes/g' /etc/ssh/sshd_config
service ssh restart

apt-get update

# make sure basic requirements are installed
REQUIREMENTS="git"
apt-get install -y -q --no-install-recommends $REQUIREMENTS

# install inspec
if [ ! -f '/usr/bin/inspec' ]; then
    apt-get install -y --no-install-recommends ruby
    curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec
fi

# install tuptime for detailed uptime
if [ ! -f '/usr/bin/tuptime' ]; then
    cd /tmp
    git clone https://github.com/rfrail3/tuptime.git
    cd tuptime
    bash tuptime-install.sh
fi

# remove banner
if [ -f '/etc/update-motd.d/50-motd-news' ]; then
    rm --interactive=never -f /etc/update-motd.d/50-motd-news
    rm --interactive=never -f /etc/update-motd.d/80-livepatch
    rm --interactive=never -f /etc/update-motd.d/51-cloudguest
    rm --interactive=never -f /etc/update-motd.d/80-esm
    rm --interactive=never -f /etc/update-motd.d/95-hwe-eol
    rm --interactive=never -f /etc/update-motd.d/91-release-upgrade
    rm --interactive=never -f /etc/update-motd.d/10-help-text
fi

# install admindojo
apt-get install -y -q python3-pip
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade admindojo

## add admindojo to PATH
echo 'PATH=$PATH:/home/vagrant/.local/bin/'>>/home/vagrant/.bashrc

# TODO check if ssh config for vagrant passwort login is needed to use putty

# TODO check if common cache for pip is needed
# download/cache admindojo python package
# python3 -m pip download admindojo -d /admindojo/client
# install admindojo from cache
# python3 -m pip install --user --upgrade --find-links -t /admindojo/client /admindojo/client/admindojo-*
