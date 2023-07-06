#!/bin/sh

mkdir -p ~/.config
mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim/skeletons

set CURRENT_DIR $(pwd)

ln -sf $CURRENT_DIR/tmux/tmux.conf ~/.tmux.conf
ln -sf $CURRENT_DIR/fish/config.fish ~/.config/fish/config.fish
ln -sf $CURRENT_DIR/vim/init.lua ~/.config/nvim/init.lua
ln -sf $CURRENT_DIR/.ackrc ~/.ackrc

for FILE in $CURRENT_DIR/vim/skeletons/*; do
  FILE_NAME=`basename $FILE`

  ln -sf $FILE ~/.config/nvim/skeletons/$FILE_NAME
done
