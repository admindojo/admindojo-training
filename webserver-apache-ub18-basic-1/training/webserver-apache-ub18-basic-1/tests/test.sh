#!/usr/bin/env bash

apt-get  update
apt install -y apache2
service apache2 enable
service apache2 start
echo "Hello World!" > /var/www/html/index.html
a2enmod ssl
a2ensite default-ssl.conf
systemctl reload apache2