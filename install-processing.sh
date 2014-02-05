#! /bin/sh

# install Processing
# by Bachir Soussi Chiadmi www.g-u-i.net
# @bachysoucychymy
# dev@g-u-i.net


# processing
cd ~/Downloads
mkdir processing
cd processing
wget http://download.processing.org/processing-2.0.1-linux64.tgz
tar -vxf processing-2.0.1-linux64.tgz
sudo mv processing-2.0.1 /opt/processing

#add processing to usr/bin
sudo ln -s /opt/processing/processing /usr/bin/processing
sudo ln -s /opt/processing/processing-java /usr/bin/processing-java

sudo echo "[Desktop Entry]
Version=2.0.1
Name=Processing
# Only KDE 4 seems to use GenericName, so we reuse the KDE strings.
# From Ubuntu's language-pack-kde-XX-base packages, version 9.04-20090413.
GenericName=Processing

Exec=processing
Terminal=false
#Icon=/opt/processing/Icon/koala.png
Type=Application
Categories=Development
X-Ayatana-Desktop-Shortcuts=NewWindow

[NewWindow Shortcut Group]
Name=New Window
Exec=processing
TargetEnvironment=Unity" > /usr/local/share/applications/processing.desktop

