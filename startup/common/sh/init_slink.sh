#!/bin/bash

## init.shの絶対パスを取得
SCRIPT_DIR=$(cd $(dirname $0); pwd)

## target
case $1 in
    "mac")
        SCRIPTNAME=".profile_mac";;
        ln -sf $SCRIPT_DIR/../../../dotfiles/bash/$SCRIPTNAME ~/.profile
    "wsl")
        SCRIPTNAME=".bashrc_wsl";;
        ln -sf $SCRIPT_DIR/../../../dotfiles/bash/$SCRIPTNAME ~/.bashrc
    *)
        SCRIPTNAME=".bashrc_ubuntu";;
        ln -sf $SCRIPT_DIR/../../../dotfiles/bash/$SCRIPTNAME ~/.bashrc
esac

## change permission
chmod +x -R $SCRIPT_DIR/../../../dotfiles/bash

## synbolic links
ln -nsf $SCRIPT_DIR/../../../dotfiles/bash/conf/ ~/conf.d
ln -nsf $SCRIPT_DIR/../../../dotfiles/.dircolors-solarized/ ~/.dircolors-solarized
ln -sf $SCRIPT_DIR/../../../dotfiles/.vimrc ~/.vimrc
ln -sf $SCRIPT_DIR/../../../dotfiles/.tmux.conf ~/.tmux.conf