#!/usr/bin/env bash
# add script to auto test training here

# remove nano
apt -y remove nano

# purging apache2
apt remove --purge ^apache2* -y
apt autoremove -y
rm -fr /etc/apache2
rm -fr /var/lib/apache2

# install nginx development
apt update
apt install nginx -y


# revert /etc/crontab
mv /etc/crontab /etc/crontab.backup
apt-get -o Dpkg::Options::="--force-confmiss" install --reinstall cron
