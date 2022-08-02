#!/bin/bash

if [ -e ~/.vim/bundle/neobundle.vim ]; then
    echo "neobundle is already exists."
else
    curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
    sh ./install.sh
fi
