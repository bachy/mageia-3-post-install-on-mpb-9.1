#! /bin/sh

# install wifi driver for braodcom 4331
# by Bachir Soussi Chiadmi www.g-u-i.net
# @bachysoucychymy
# dev@g-u-i.net

# see [this forum tread](http://www.mageialinux-online.org/forum/topic-15859+macbook-pro-9-1-broadcom-4331-m3.php)

# run as sudo

urpmi --auto b43-fwcutter b43-openfwwf b43-tools
cd ~/Downloads
mkdir broadcom-4331
cd broadcom-4331
wget http://www.lwfinger.com/b43-firmware/broadcom-wl-5.100.138.tar.bz2
tar -xjf broadcom-wl-5.100.138.tar.bz2
b43-fwcutter -w /lib/firmware/ broadcom-wl-5.100.138/linux/wl_apsta.o
rmmod b43
modprobe b43

# you should not install broadcom-bcma-config and rfkill
# you should reboot after that