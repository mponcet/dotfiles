#!/bin/bash

set -o xtrace

FONTS_DIR=~/.local/share/fonts

install_fonts() {
	mkdir -p $FONTS_DIR
	nerd_fira_code_fonts_url=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest|jq '.assets[] | select(.name == "FiraCode.zip") | .browser_download_url')
	curl -s -O /tmp/FiraCode.zip $nerd_fira_code_fonts_url
	unzip -o /tmp/FiraCode.zip -d $FONTS_DIR
}

install_fonts

cp .bashrc ~/
cp -r .bashrc.d ~/
cp .bash_profile ~/
cp .bash_logout ~/

cp .gitconfig ~/

cp -r .config/nvim ~/.config/

cp -r .config/alacritty ~/.config/

cp .tmux.conf ~/

cp -r .local/bin ~/.local
