#! /bin/sh

#re-create an rc.local fonctionality
#http://linuxtricks.asso-linux-online.fr/wiki/systemd-restaurer-la-fonctionnalite-rc-local
# THIS DOES NOT WORK FOR ME :(

# by Bachir Soussi Chiadmi www.g-u-i.net
# @bachysoucychymy
# dev@g-u-i.netch

echo "[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
 
[Service]
Type=forking
ExecStart=/bin/sh -c '/etc/rc.local'
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
 
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/rc-local.service

chmod a+x /etc/systemd/system/rc-local.service

echo "#! /bin/sh
#Ajouter le code ICI avant exit 0
 
exit 0" > /etc/rc.local

chmod a+x /etc/rc.local