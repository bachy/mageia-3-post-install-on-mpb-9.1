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

# install basic softwares
urpmi --auto git synapse chromium-browser-stable nano gnome-tweak-tool gconf-editor

# gnome change workspace dual screen default behavior
# http://gregcor.com/2011/05/07/fix-dual-monitors-in-gnome-3-aka-my-workspaces-are-broken/
gsettings set org.gnome.shell.overrides workspaces-only-on-primary false 

# Add shared home partition
mkdir /mnt/$dataVolume
mount /dev/sda6 /mnt/$dataVolume
echo "/dev/sda6 /mnt/$dataVolume auto rw,user,auto 0 0" >> /etc/fstab

# #Desktop
# rm -rf /home/$userName/Desktop
# ln -s /mnt/$dataVolume/$userName/Desktop /home/$userName/Desktop
# # Document
# rm -rf /home/$userName/Documents
# ln -s /mnt/$dataVolume/$userName/Documents /home/$userName/Documents
# # Pictures
# rm -rf /home/$userName/Images
# ln -s /mnt/$dataVolume/$userName/Pictures /home/$userName/Pictures
# #Templates
# rm -rf /home/$userName/Modèles
# ln -s /mnt/$dataVolume/$userName/Templates /home/$userName/Templates
# #Music
# rm -rf /home/$userName/Musique
# ln -s /mnt/$dataVolume/$userName/Music /home/$userName/Music
# #Downloads
# rm -rf /home/$userName/Téléchargement
# ln -s /mnt/$dataVolume/$userName/Downloads /home/$userName/Downloads
# #Movies
# rm -rf /home/$userName/Vidéos
# ln -s /mnt/$dataVolume/$userName/Movies /home/$userName/Movies
# #MISC
# ln -s /mnt/$dataVolume/$userName/Dropbox /home/$userName/Dropbox
# ln -s /mnt/$dataVolume/$userName/Copy /home/$userName/Copy
# ln -s /mnt/$dataVolume/$userName/Developper /home/$userName/Developper
# ln -s /mnt/$dataVolume/$userName/Sites /home/$userName/Sites



# liquidpompt
cd ~/Developper
got clone https://github.com/nojhan/liquidprompt.git
echo "source ~/Developper/liquidprompt/liquidprompt" >> ~/.bashrc

# git config
git config --global user.name $fullUserName
git config --global user.email $userEmail
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=7200'


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

# LAMP #
# http://linuxtricks.asso-linux-online.fr/wiki/installer-un-serveur-lamp-sous-mageia
urpmi task-lamp

#replace apache user to match with osx apache user _www:_www
groupadd _www
useradd _www _www
usermod -u 70 _www
groupmod -u 70 _www

sed -i 's/User apache/User _www/g' /etc/httpd/conf/httpd.conf
sed -i 's/Group apache/Group _www/g' /etc/httpd/conf/httpd.conf


# Before that we should mount MacOsX
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

# Todo : place next lines for each vhosts
# <Directory "/home/bachir/Sites/materio/base_d7">
#      Require local
# </Directory>

# php conf
sed -i 's/memory_limit = 128M/memory_limit = 256M/g' /etc/php.ini
urpmi --auto php-pdo_mysql

# start lamp services
service htpd start
service mysqld start

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



 
