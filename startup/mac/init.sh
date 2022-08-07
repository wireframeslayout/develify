
#!/bin/bash

echo "Mac Install Start."

## init.shの絶対パスを取得
SCRIPT_DIR=$(cd $(dirname $0); pwd)

## init synbolic link
bash $SCRIPT_DIR/../common/sh/init_slink.sh mac

## install starship
bash $SCRIPT_DIR/../common/sh/install_starship.sh

## install anyenv
bash $SCRIPT_DIR/../common/sh/install_anyenv.sh

## install exa
bash $SCRIPT_DIR/../common/sh/install_exa.sh mac

## install neobundle
bash $SCRIPT_DIR/../common/vim/install_neobundle.sh

source ~/.bashrc