#! /bin/sh

suod urpmi --auto git

# git config
git config --global user.name $fullUserName
git config --global user.email $userEmail
#git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=7200'
git config --global color.ui true
git config --global core.excludesfile '~/.gitignore_global'
echo "*.sublime-project" >> ~/.gitignore_global
echo "*.sublime-workspace" >> ~/.gitignore_global
