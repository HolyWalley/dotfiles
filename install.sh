#!/bin/sh

apt update
apt install build-essential libssl-dev zlib1g-dev -y

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0

mkdir ~/.config
mkdir ~/.config/nvim

CURRENT_DIR=`pwd`

ln -sf $CURRENT_DIR/zsh/.zshrc ~/.zshrc
ln -sf $CURRENT_DIR/tmux/tmux.conf ~/.tmux.conf
ln -sf $CURRENT_DIR/vim/init.lua ~/.config/nvim/init.lua
