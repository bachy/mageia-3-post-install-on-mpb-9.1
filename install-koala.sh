#! /bin/sh

# install Koala
# by Bachir Soussi Chiadmi www.g-u-i.net
# @bachysoucychymy
# dev@g-u-i.net

# i can't download automaticly koala because it hosted on aws :(

exit 0

#sublime text 2
cd ~/Downloads
mkdir koala
cd koala
wget http://www.amazon.com/gp/drive/share?ie=UTF8&s=XlyllWIaRGUtaowrguawjs#
gunzip koala_1.4.1_amd64.tar.gz
tar -vxf koala_1.4.1_amd64.tar
sudo mv koala_1.4.1_amd64 /opt/koala

#add koala to usr/bin
sudo ln -s /opt/koala/koala /usr/bin/koala

# fix libudev.so.0 missing bug
ln -s /lib64/libudev.so.1.1.6 /lib64/libudev.so.0

sudo echo "[Desktop Entry]
Version=1.4.1
Name=Koala
# Only KDE 4 seems to use GenericName, so we reuse the KDE strings.
# From Ubuntu's language-pack-kde-XX-base packages, version 9.04-20090413.
GenericName=Less Compiler

Exec=koala
Terminal=false
Icon=/opt/koala/Icon/koala.png
Type=Application
Categories=LessCompiler;Development
X-Ayatana-Desktop-Shortcuts=NewWindow

[NewWindow Shortcut Group]
Name=New Window
Exec=koala
TargetEnvironment=Unity" > /usr/local/share/applications/sublime.desktop

