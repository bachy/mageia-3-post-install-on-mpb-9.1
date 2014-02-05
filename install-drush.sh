#! /bin/sh

#install drush
cd /home/bachir/Downloads
mkdir drush
cd drush
wget http://ftp.drupal.org/files/projects/drush-7.x-5.9.tar.gz
tar -xjf drush-7.x-5.9.tar.gz
sudo mv drush /opt/
sudo ln -s /opt/drush/drush /usr/bin/drush


 