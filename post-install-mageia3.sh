# post install mageia 3 on MacBookPro 9.1

# change bachir uid to 501 as osx user to share the same home folders
# id -u bachir
# sudo useradd -d /home/tempuser -m -s /bin/bash -G bachir tempuser
# sudo usermod —uid 502 tempuser
# sudo chown -R 502:bachir /home/tempuser
#
# restart as tempuser and then
# sudo usermod —uid 501 bachir
# sudo chown -R 501:bachir /home/bachir
# 
# restart as bachir and then
# userdel -r tempuser

su

# Add shared home partition
mkdir /mnt/Home
mount /dev/sda5 /mnt/Home
echo "/dev/sda5 /mnt/Home auto rw,user,auto 0 0" >> /etc/fstab

#Desktop
rm -rf /home/bachir/Desktop
ln -s /mnt/Home/bachir/Desktop /home/bachir/Desktop
# Document
rm -rf /home/bachir/Documents
ln -s /mnt/Home/bachir/Documents /home/bachir/Documents
# Pictures
rm -rf /home/bachir/Images
ln -s /mnt/Home/bachir/Pictures /home/bachir/Pictures
#Templates
rm -rf /home/bachir/Modèles
ln -s /mnt/Home/bachir/Templates /home/bachir/Templates
#Music
rm -rf /home/bachir/Musique
ln -s /mnt/Home/bachir/Music /home/bachir/Music
#Downloads
rm -rf /home/bachir/Téléchargement
ln -s /mnt/Home/bachir/Downloads /home/bachir/Downloads
#Movies
rm -rf /home/bachir/Vidéos
ln -s /mnt/Home/bachir/Movies /home/bachir/Movies
#MISC
ln -s /mnt/Home/bachir/Dropbox /home/bachir/Dropbox
ln -s /mnt/Home/bachir/Copy /home/bachir/Copy
ln -s /mnt/Home/bachir/Developper /home/bachir/Developper
ln -s /mnt/Home/bachir/Sites /home/bachir/Sites

# install wifi drivers
urpmi --auto b43-fwcutter b43-openfwwf b43-tools
cd /home/bachir/Downloads
mkdir broadcom-4331
cd broadcom-4331
wget http://www.lwfinger.com/b43-firmware/broadcom-wl-5.100.138.tar.bz2
tar -xjf broadcom-wl-5.100.138.tar.bz2
b43-fwcutter -w /lib/firmware/ broadcom-wl-5.100.138/linux/wl_apsta.o
rmmod b43
modprobe b43
# you should not instalkl broadcom-bcma-config and rfkill
# you should reboot after that

# install basic softwares
urpmi --auto git synapse chromium-web-browser



#Add synapse to boot


#sublime text 2



