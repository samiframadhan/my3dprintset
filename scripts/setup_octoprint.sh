#!/usr/bin/env bash

cd /home/pi

#Dependencies installation
sudo apt install nano git curl

#Downloading config files
echo "Downloading config files"
git clone https://github.com/samiframadhan/my3dprintset.git

#Replacing config files
echo "Replacing config files"
sudo cp my3dprintset/octopi/octopi.txt /boot/octopi.txt
sudo mkdir /boot/octopi.conf.d
sudo cp my3dprintset/octopi/octopi.conf.d/webcam2.txt /boot/octopi.conf.d/webcam2.txt
sudo cp my3dprintset/octopi/haproxy.cfg /etc/haproxy/haproxy.cfg

haproxytest=$(haproxy -c -V -f /etc/haproxy/haproxy.cfg)

if [[ $haproxytest -e "Configuration file is valid" ]]
then
echo "Haproxy install successful";
else
echo "Haproxy install misconfigured"
fi

echo "To implement changes, the raspberry pi"
echo "needs to be restarted"
echo "Restart now?[y/n]"
read confirm

if [[ $confirm == "y" ]] || [[ $confirm == "Y" ]]
then
echo "Restarting raspberry pi..."

sudo reboot
