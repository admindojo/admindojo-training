#!/usr/bin/env bash
# add script to auto test training here

# remove nano
apt -y remove nano


# install nginx development
apt update
apt install nginx -y


# purging apache2
apt remove --purge ^apache2* -y
apt autoremove -y
rm -fr /etc/apache2
rm -fr /var/lib/apache2
