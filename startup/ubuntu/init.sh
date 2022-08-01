#!/bin/bash


## synbolic links
ln -sf ~/develify/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/develify/dotfiles/.dircolors-solarized ~/.dircolors-solarized
ln -sf ~/develify/dotfiles/.vimrc ~/.vimrc
ln -sf ~/develify/dotfiles/.tmux.conf ~/.tmux.conf

## install starship
bash ../common/install_starship.sh
bash ../common/install_starship_font_linux.sh

## install exa
wget https://github.com/ogham/exa/releases/download/v0.10.0/exa-linux-x86_64-v0.10.0.zip
sudo unzip exa-linux-x86_64-v0.10.0.zip -d ~/exa
sudo mv ~/exa/bin/exa /usr/local/bin/exa
rm -rf ~/exa


git clone https://github.com/anyenv/anyenv ~/.anyenv

source ~/.bash_profile