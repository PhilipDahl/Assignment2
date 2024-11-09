#!/bin/bash

#ensure that the user is executing the file as root

if [[ $EUID -ne 0 ]]; then
        echo "Script must be run as root or with sudo"
        exit 1
fi

#create required directories if not already created
mkdir -p ~/bin
mkdir -p ~/config/kak
mkdir -p ~/config/tmux

#Create symbolic links using a source and using its destination overwriting any links that may have been created previously with the same name.
ln -sf "$(pwd)/bin/sayhi" ~/bin/sayhi
ln -sf "$(pwd)/bin/install-fonts" ~/bin/install-fonts
ln -sf "$(pwd)/config/kak/kakrc" ~/config/kak/kakrc
ln -sf "$(pwd)/config/tmux/tmux.conf" ~/config/tmux/tmux.conf
ln -sf "$(pwd)/home/bashrc"~/bashrc