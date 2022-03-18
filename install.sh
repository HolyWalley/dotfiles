#!/bin/sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mkdir ~/.config
mkdir ~/.config/nvim

CURRENT_DIR=`pwd`

ln -sf $CURRENT_DIR/zsh/.zshrc ~/.zshrc
ln -sf $CURRENT_DIR/tmux/tmux.conf ~/.tmux.conf
ln -sf $CURRENT_DIR/vim/init.vim ~/.config/nvim/init.vim
