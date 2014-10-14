#! /bin/sh

# LAMP #
# http://linuxtricks.asso-linux-online.fr/wiki/installer-un-serveur-lamp-sous-mageia
urpmi task-lamp task-lamp-extras

#replace apache user to match with osx apache user _www:_www
# groupadd _www
# useradd _www _www
# usermod -u 70 _www
# groupmod -u 70 _www

# sed -i 's/User apache/User _www/g' /etc/httpd/conf/httpd.conf
# sed -i 's/Group apache/Group _www/g' /etc/httpd/conf/httpd.conf

# php conf
sed -i 's/memory_limit = 128M/memory_limit = 256M/g' /etc/php.ini
urpmi --auto php-pdo_mysql

# start lamp services
service httpd start
service mysqld start

#mysql
MysqlUser = "root"
MysqlPass = "__________"
mysqladmin -u $MysqlUser password $MysqlPass

# TODO
# setup the export all dbs in cron script



# Todo : import all db automaticly 
# cd ~/Developper/mysql.back
# for file in *; 
# do
#    if [[ $file == ^.*\.sql$ ]]; then
#       DbName = sed 's/.sql//g' $echo
#      mysqladmin -u $MysqlUser -p$MysqlPass create $DbName
#     mysql -u $MysqlUser -p$MysqlPass $DbName < $file
#    fi
# done
