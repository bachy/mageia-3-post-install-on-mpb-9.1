#Mageia 3 on macbookpro 9.1

this is  my script as a note book about the installation of linux mageia 3 Gnome desktop on my Macbook Pro 9.1

/!\ you should read carrefully all the scripts before anything else 

/!\ i never ran directly the main script post-install-mageia3.sh, i follow the lines and type commands by hand on a console, other specific scripts can be executed

/!\ WORK IN PROGRESS

##share the same user uid between mac osx and linux
this can't run through a script so you will have to make it by your self
get this from [here](http://lifehacker.com/5702815/the-complete-guide-to-sharing-your-data-across-multiple-operating-systems)

####change linux user uid to 501 as osx user to share the same home folders
```Batchfile
su
id -u yourusername
useradd -d /home/tempuser -m -s /bin/bash -G yourusername tempuser
usermod -u 502 tempuser
chown -R 502:yourusername /home/tempuser
```
####restart as tempuser and then
```Batchfile
su
usermod -u 501 yourusername
chown -R 501:yourusername /home/yourusername
```
####restart as yourusername and then
```Batchfile
su
userdel -r tempuser
```
 


 to be continued