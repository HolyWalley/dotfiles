#!/bin/sh

mkdir -p ~/.config
mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim/skeletons
mkdir -p ~/.ssh

ln -sf $PWD/tmux/tmux.conf ~/.tmux.conf
ln -sf $PWD/fish/config.fish ~/.config/fish/config.fish
ln -sf $PWD/vim/init.lua ~/.config/nvim/init.lua
ln -sf $PWD/.ackrc ~/.ackrc
ln -sf $PWD/.ssh/config ~/.ssh/config

for FILE in $PWD/vim/skeletons/*; do
  FILE_NAME=`basename $FILE`

  ln -sf $FILE ~/.config/nvim/skeletons/$FILE_NAME
done
