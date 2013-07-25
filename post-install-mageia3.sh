##! /bin/sh

# post install mageia 3 on MacBookPro 9.1
# by Bachir Soussi Chiadmi www.g-u-i.net
# @bachysoucychymy
# dev@g-u-i.net

userName = "bachir" # must be the same between osx and linux
fullUserName = "Bachir Soussi Chiadmi";
OsxVolume = "Osx" # volume where is installed your osx systeme (used for transfert and adapte apache2 config)
userEmail = "bachir@g-u-i.net"
$dataVolume = "Data"

su

# instal sudo
urpmi sudo
echo "$userName ALL=(ALL) ALL" >> /etc/sudoers

# install basic softwares
sudo urpmi --auto git synapse chromium-browser-stable nano gnome-tweak-tool gconf-editor

# gnome change workspace dual screen default behavior
# http://gregcor.com/2011/05/07/fix-dual-monitors-in-gnome-3-aka-my-workspaces-are-broken/
gsettings set org.gnome.shell.overrides workspaces-only-on-primary false 

# apdapte apple key board
# set fucntions key as default (https://help.ubuntu.com/community/AppleKeyboard)
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode
# permanently : add the command in /etc/rc.local if exists (use the create-rclocal-service.sh script)
if [ -f /etc/rc.local ]; then
  sed -i 's/exit 0/echo 2 | sudo tee \/sys\/module\/hid_apple\/parameters\/fnmode \nexit 0/g' /etc/rc.local
fi
# swap missplaced keys on usb external apple keyboard(ctr/<>)
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

# echo "[Desktop Entry]
# Name=Xmodmap
# GenericName=Keyboard Remapping
# Comment=Remap the Control and Command Keys on the MBP 8,2
# Exec=xmodmap ~/.Xmodmap
# Terminal=false
# Type=Application
# Categories=Keyboard;
# StartupNotify=false" > ~/.config/autostart/xmodmap.desktop

# OR from https://bbs.archlinux.org/viewtopic.php?id=156257"
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


# Add shared home partition
mkdir /mnt/$dataVolume
mount /dev/sda6 /mnt/$dataVolume
echo "/dev/sda6 /mnt/$dataVolume auto rw,user,auto 0 0" >> /etc/fstab

#Desktop
rm -rf /home/$userName/Desktop
ln -s /mnt/$dataVolume/$userName/Desktop /home/$userName/Desktop
# Document
rm -rf /home/$userName/Documents
ln -s /mnt/$dataVolume/$userName/Documents /home/$userName/Documents
# Pictures
rm -rf /home/$userName/Images
ln -s /mnt/$dataVolume/$userName/Pictures /home/$userName/Pictures
#Templates
rm -rf /home/$userName/Modèles
ln -s /mnt/$dataVolume/$userName/Templates /home/$userName/Templates
#Music
rm -rf /home/$userName/Musique
ln -s /mnt/$dataVolume/$userName/Music /home/$userName/Music
#Downloads
rm -rf /home/$userName/Téléchargement
ln -s /mnt/$dataVolume/$userName/Downloads /home/$userName/Downloads
#Movies
rm -rf /home/$userName/Vidéos
ln -s /mnt/$dataVolume/$userName/Movies /home/$userName/Movies
#MISC
ln -s /mnt/$dataVolume/$userName/Dropbox /home/$userName/Dropbox
ln -s /mnt/$dataVolume/$userName/Copy /home/$userName/Copy
ln -s /mnt/$dataVolume/$userName/Developper /home/$userName/Developper
ln -s /mnt/$dataVolume/$userName/Sites /home/$userName/Sites

su $userName
# install wifi drivers
sudo urpmi --auto b43-fwcutter b43-openfwwf b43-tools
cd /home/$userName/Downloads
mkdir broadcom-4331
cd broadcom-4331
wget http://www.lwfinger.com/b43-firmware/broadcom-wl-5.100.138.tar.bz2
tar -xjf broadcom-wl-5.100.138.tar.bz2
sudo b43-fwcutter -w /lib/firmware/ broadcom-wl-5.100.138/linux/wl_apsta.o
sudo rmmod b43
sudo modprobe b43
# you should not instalkl broadcom-bcma-config and rfkill
# you should reboot after that

# liquidpompt
cd ~/Developper
got clone https://github.com/nojhan/liquidprompt.git
echo "source ~/Developper/liquidprompt/liquidprompt" >> ~/.bashrc

# git config
git config --global user.name $fullUserName
git config --global user.email $userEmail

# install chrome
sudo urpmi.addmedia --update chrome_x86_64 http://dl.google.com/linux/chrome/rpm/stable/x86_64
sudo rpm --import https://dl-ssl.google.com/linux/linux_signing_key.pub
sudo urpmi --auto --force google-chrome-stable


# install drop box
sudo urpmi --auto nautilus-dropbox-1.6.0-1.mga3.nonfree.x86_64

# install skype
# not so simple : http://www.mageialinux-online.org/wiki/installer-skype-sur-sa-mageia
# sudo urpmi --auto get-skype

# install filezilla
sudo urpmi --auto filezilla
# http://www.code-zen.net/2009/syncing-filezilla-sites-across-computers-with-dropbox/

# LAMP #
# http://linuxtricks.asso-linux-online.fr/wiki/installer-un-serveur-lamp-sous-mageia
sudo urpmi task-lamp

# Before that we should mount MacOsX
su
mount $OsxVolume

mv /etc/hosts /etc/hosts.back
cp run/media/bachir/$MacVolume/etc/hosts /etc/hosts

mkdir /etc/httpd/conf/users.d
cp run/media/bachir/$MacVolume/etc/apache2/users/bach.conf /etc/httpd/conf/users.d
echo "
# Include users config
Include conf/users.d/*.conf" >> /etc/httpd/conf/httpd.conf

# remove these lines
# ErrorLog "/private/var/log/apache2/materio-error_log"
# CustomLog "/private/var/log/apache2/materio-access_log" common

#sed -i 's/ErrorLog/# ErrorLog/g' /etc/httpd/conf/users.d/bach.conf
#sed -i 's/CustomLog/# CustomLog/g' /etc/httpd/conf/users.d/bach.conf
sed -i 's/private\/var\/log\/apache2/var\/logs\/httpd/g' /etc/httpd/conf/users.d/bach.conf
sed -i 's/\/Users\/bachir\/Sites/\/home\/bachir\/Sites/g' /etc/httpd/conf/users.d/bach.conf

# Todo : place next line for each vhosts  but how ??
# <Directory "/home/bachir/Sites/materio/base_d7">
#      Require local
# </Directory>p


# php conf
sed -i 's/memory_limit = 128M/memory_limit = 256M/g' /etc/php.ini
urpmi --auto php-pdo_mysql

# start lamp services
sudo service htpd start
sudo service mysqld start

#mysql
MysqlUser = "root"
MysqlPass = "Lhip2L2Mysql!"
mysqladmin -u $MysqlUser password $MysqlPass

# Todo : import all db automaticly 
# cd ~/Developper/mysql.back
# for file in *; 
# do
#    if [[ $file == ^.*\.sql$ ]]; then
#       DbName = sed 's/.sql//g' $echo
# 	   mysqladmin -u $MysqlUser -p$MysqlPass create $DbName
#	    mysql -u $MysqlUser -p$MysqlPass $DbName < $file
#    fi
# done



 
