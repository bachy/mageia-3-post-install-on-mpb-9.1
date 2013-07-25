#Mageia 3 on macbookpro 9.1

this is  my script as a note book about the installation of linux mageia 3 on my mac book pro 9.1

/!\ you should read carrefully all the scripts before anything else 

/!\ i never ran directly the main script post-install-mageia3.sh, i follow the lines and type commands by hand on a console, other specific scripts can be executed


##share the same user uid between mac osx and linux
this can't run through a script so you will have to make it by your self

###change linux user uid to 501 as osx user to share the same home folders
    id -u yourusername
    sudo useradd -d /home/tempuser -m -s /bin/bash -G yourusername tempuser
    sudo usermod -u 502 tempuser
    sudo chown -R 502:yourusername /home/tempuser

###restart as tempuser and then
    sudo usermod -u 501 yourusername
    sudo chown -R 501:yourusername /home/yourusername
 
###restart as yourusername and then
    userdel -r tempuser
 