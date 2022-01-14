#!/bin/bash

set -o xtrace

distro=$(grep "^ID=" /etc/os-release | cut -d'=' -f2 | sed -e 's/"//g')

install_pwndbg() {
	case $distro in
	"fedora")
		if cd ~/.pwndbg
		then
			git pull
		else
			git clone --depth 1 https://github.com/pwndbg/pwndbg ~/.pwndbg
			cd ~/.pwndbg
		fi
		./setup.sh
		cd -
		;;
	"arch")
		sudo pacman -S pwndbg
		echo "source /usr/share/pwndbg/gdbinit.py" > ~/.gdbinit
		;;
	*)
		echo \"$distro\" is not supported
		exit 1
		;;
	esac
}

install_dnf() {
	sudo dnf install -y alacritty tmux git neovim fzf powerline-go powerline-fonts nodejs
}

install_arch() {
	sudo pacman -S alacritty tmux git neovim fzf nodejs pwndbg
	yay -S powerline-go
}


# Fedora packages:

case $distro in
	"fedora")
		install_dnf
		install_pwndbg
		;;
	"arch")
		install_arch
		;;
	*)
		echo \"$distro\" is not supported
		exit 1
		;;
esac

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
