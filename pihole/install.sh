#!/usr/bin/sh

echo "Configuring local DNS for homebridge"
sudo echo "192.168.0.105\thomebridge" >> /etc/hosts

curl -sSL https://install.pi-hole.net | sudo bash

sudo sed -i 's/server\.port\s*=\s*80/server.port = 8080/' /etc/lighttpd/lighttpd.conf
sudo service lighttpd restart
