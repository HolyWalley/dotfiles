#!/bin/sh

USER_PATH="/Users/$(whoami)"

mkdir -p ~/.config
mkdir -p ~/.config/nvim/lua
mkdir -p ~/.config/nvim/lua/config
mkdir -p ~/.config/nvim/lua/plugins
mkdir -p ~/.config/fish/themes

ln -sf $PWD/fish/config.fish ~/.config/fish/config.fish
ln -sf $PWD/fish/fish_plugins ~/.config/fish/fish_plugins
ln -sf $PWD/fish/tokyonight_storm.theme ~/.config/fish/themes/tokyonight_storm.theme

rm -f ~/.config/nvim/init.lua
ln -sf $PWD/nvim/init.lua ~/.config/nvim/init.lua

for file in "$PWD/nvim/lua/config"/*; do
	# Extract the filename from the path
	filename=$(basename "$file")
	target_file="$USER_PATH/.config/nvim/lua/plugins/$filename"

	rm -f "$target_file"
	# Create a symbolic link in the target directory
	ln -sf "$file" "$target_file"
done

for file in "$PWD/nvim/lua/plugins"/*; do
	# Extract the filename from the path
	filename=$(basename "$file")
	target_file="$USER_PATH/.config/nvim/lua/plugins/$filename"

	rm -f "$target_file"
	# Create a symbolic link in the target directory
	ln -sf "$file" "$target_file"
done
