#!/usr/bin/env bash
apt-get  update
apt-get install -y apache2
systemctl enable apache2
systemctl start apache2
echo "Hello World!" > /var/www/html/index.html
a2enmod ssl
a2ensite default-ssl.conf
systemctl reload apache2