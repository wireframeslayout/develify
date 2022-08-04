
#!/bin/zsh

echo "Mac Zsh Install Start."

## init.shの絶対パスを取得
SCRIPT_DIR=$(cd $(dirname $0); pwd)

## init synbolic link
bash $SCRIPT_DIR/../common/zsh/init_slink.zsh mac

bash $SCRIPT_DIR/install_homebrew.sh

source ~/.zshrc

## install starship
bash $SCRIPT_DIR/../common/sh/install_starship.sh

## install anyenv
bash $SCRIPT_DIR/../common/sh/install_anyenv.sh

## install exa
bash $SCRIPT_DIR/../common/sh/install_exa.sh mac

## install neobundle
bash $SCRIPT_DIR/../common/vim/install_neobundle.sh

source ~/.zshrc