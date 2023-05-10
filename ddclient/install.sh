#!/usr/bin/sh

sudo apt update
sudo apt install ddclient

sudo cp ddclient.conf /etc/ddclient.conf
sudo systemctl restart ddclient
