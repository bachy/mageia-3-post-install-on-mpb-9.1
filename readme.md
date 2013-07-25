#Mageia 3 on macbookpro 9.1 post install config script

this is  my script as a note book about the installation of linux mageia on my mac book por 9.1


##setu up the same user uuid between mac osx and linux
this can't run through a script so you will have to made it by your self

###change $userName uid to 501 as osx user to share the same home folders
id -u $userName
sudo useradd -d /home/tempuser -m -s /bin/bash -G $userName tempuser
sudo usermod -u 502 tempuser
sudo chown -R 502:$userName /home/tempuser

###restart as tempuser and then
sudo usermod -u 501 $userName
sudo chown -R 501:$userName /home/$userName
 
###restart as $userName and then
userdel -r tempuser
 