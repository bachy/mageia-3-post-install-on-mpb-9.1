##! /bin/sh

# configure keyboard
# by Bachir Soussi Chiadmi www.g-u-i.net
# @bachysoucychymy
# dev@g-u-i.net


# run create-rclocal-service.sh before this script

# set fucntions key as default (https://help.ubuntu.com/community/AppleKeyboard)
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
# permanently : add the command in /etc/rc.local if exists (use the create-rclocal-service.sh script)
if [ -f /etc/rc.local ]; then
  sed -i 's/exit 0/echo 2 | sudo tee \/sys\/module\/hid_apple\/parameters\/fnmode \nexit 0/g' /etc/rc.local
fi

# swap missplaced keys on usb external apple keyboard(ctr/<>)
# mbp keyboard wont work properly after that, you'll have to reverse the process to sue it
echo 0 | sudo tee /sys/module/hid_apple/parameters/iso_layout
# permanently : add the command in /etc/rc.local if exists (use the create-rclocal-service.sh script)
if [ -f /etc/rc.local ]; then
  sed -i 's/exit 0/echo 0 | sudo tee \/sys\/module\/hid_apple\/parameters\/iso_layout \nexit 0/g' /etc/rc.local
fi

# swap ctrl and command keys (two options tested the frist one)
# http://stackoverflow.com/questions/7099602/cmd-control-keys-swap-in-ubuntu
echo "clear control
clear mod4

keycode 105 =
keycode 206 =

keycode 133 = Control_L NoSymbol Control_L
keycode 134 = Control_R NoSymbol Control_R
keycode 37 = Super_L NoSymbol Super_L

add control = Control_L
add control = Control_R
add mod4 = Super_L" > ~/.Xmodmap

sudo echo "xmodmap ~/.Xmodmap" >> ~/.bashrc 

# following is not working

# echo "[Desktop Entry]
# Name=Xmodmap
# GenericName=Keyboard Remapping
# Comment=Remap the Control and Command Keys on the MBP 8,2
# Exec=xmodmap ~/.Xmodmap
# Terminal=false
# Type=Application
# Categories=Keyboard;
# StartupNotify=false" > ~/.config/autostart/xmodmap.desktop

# OR

# from https://bbs.archlinux.org/viewtopic.php?id=156257"
# echo "remove control = Control_L
# remove mod4 = Super_L Super_R
# keysym Control_L = Super_L
# keysym Super_L = Control_L
# keysym Super_R = Control_L
# add control = Control_L Control_R
# add mod4 = Super_L Super_R" > /etc/X11/xinit/.Xmodmap 

# echo "[Desktop Entry]
# Name=Xmodmap
# GenericName=Keyboard Remapping
# Comment=Remap the Control and Command Keys on the MBP 8,2
# Exec=xmodmap /etc/X11/xinit/.Xmodmap
# Terminal=false
# Type=Application
# Categories=Keyboard;
# StartupNotify=false" > ~/.config/autostart/xmodmap.desktop
