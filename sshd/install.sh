#!/usr/bin/sh

sudo cp sshd_config /etc/ssh/sshd_config
sudo systemctl enable ssh
sudo systemctl start ssh
