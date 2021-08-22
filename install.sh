#!/bin/bash

set -o xtrace

install_pwndbg() {
	if cd ~/.pwndbg
	then
		git pull
	else
		git clone --depth 1 https://github.com/pwndbg/pwndbg ~/.pwndbg
		cd ~/.pwndbg
	fi
	./setup.sh
}


# Fedora packages:
sudo dnf install -y alacritty tmux git neovim fzf powerline-go powerline-fonts nodejs

# bash:
cp .bashrc ~/
cp .bash_profile ~/
cp .bash_logout ~/

# nvim:
cp -r .config/nvim ~/.config/

# alacritty
cp -r .config/alacritty ~/.config/

# tmux
cp .tmux.conf ~/

# setup pwndbg
install_pwndbg
