#!/usr/bin/sh

sudo apt update
sudo apt install nginx

sudo cp conf/* /etc/nginx/conf.d/.
sudo systemctl restart nginx
