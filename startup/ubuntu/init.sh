#!/bin/bash

echo "Ubuntu Install Start."

## init.shの絶対パスを取得
SCRIPT_DIR=$(cd $(dirname $0); pwd)

## parse options
WITH_GOTTY=false
for arg in "$@"; do
    case "$arg" in
        --with-gotty) WITH_GOTTY=true ;;
    esac
done

## init synbolic link
bash $SCRIPT_DIR/../common/sh/init_slink.sh ubuntu

## install starship
bash $SCRIPT_DIR/../common/sh/install_starship.sh

## install oh-my-posh
bash $SCRIPT_DIR/../common/sh/install_ohmyposh.sh

## install anyenv
bash $SCRIPT_DIR/../common/sh/install_anyenv.sh

## install exa
bash $SCRIPT_DIR/../common/sh/install_exa.sh

## install tpm (tmux plugin manager)
bash $SCRIPT_DIR/../common/sh/install_tpm.sh

## install neobundle
bash $SCRIPT_DIR/../common/vim/install_neobundle.sh

## install gotty (optional)
if $WITH_GOTTY; then
    bash $SCRIPT_DIR/../common/sh/install_gotty.sh
fi

source ~/.bashrc