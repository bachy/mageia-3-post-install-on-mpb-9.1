#! /bin/sh

# post install mageia 3 on MacBookPro 9.1
# by Bachir Soussi Chiadmi www.g-u-i.net
# @bachysoucychymy
# dev@g-u-i.net

userName = "yourusername" # must be the same between osx and linux
fullUserName = "Your Full Name";
OsxVolume = "Osx" # volume where is installed your osx systeme (used for transfert and adapte apache2 config)
userEmail = "your@email.com"
$dataVolume = "Data"

# instal sudo
urpmi sudo
echo "$userName ALL=(ALL) ALL" >> /etc/sudoers

# see configure-keyboard.sh

# install synaptic for the trackpad
sudo urpmi --auto x11-driver-input-synaptics x11-driver-input-synaptics-devel

# change hostname
# http://forum.mandriva.com/en/viewtopic.php?t=131866
sudo sed -i 's/HOSTNAME=localhost.localdomain/HOSTNAME=mbp_bach_mageia/'
sudo service network restart
# or 
# sudo drakconnect --internet

# install basic softwares
urpmi --auto synapse zeitgeist bc
urpmi --auto chromium-browser-stable gajim
urpmi --auto gnome-tweak-tool gconf-editor

# gnome change workspace dual screen default behavior
# http://gregcor.com/2011/05/07/fix-dual-monitors-in-gnome-3-aka-my-workspaces-are-broken/
gsettings set org.gnome.shell.overrides workspaces-only-on-primary false 

# Add shared home partition
mkdir /mnt/$dataVolume
mount /dev/sda6 /mnt/$dataVolume
echo "/dev/sda6 /mnt/$dataVolume auto rw,user,auto 0 0" >> /etc/fstab

# liquidpompt
cd ~/Developper
git clone https://github.com/nojhan/liquidprompt.git
echo "source ~/Developper/liquidprompt/liquidprompt" >> ~/.bashrc

# install chrome
urpmi.addmedia --update chrome_x86_64 http://dl.google.com/linux/chrome/rpm/stable/x86_64
rpm --import https://dl-ssl.google.com/linux/linux_signing_key.pub
urpmi --auto --force google-chrome-stable

# install drop box
urpmi --auto nautilus-dropbox-1.6.0-1.mga3.nonfree.x86_64

# install skype
# not so simple : http://www.mageialinux-online.org/wiki/installer-skype-sur-sa-mageia
# urpmi --auto get-skype

# install filezilla
urpmi --auto filezilla
# http://www.code-zen.net/2009/syncing-filezilla-sites-across-computers-with-dropbox/

