#!/bin/bash

set -o xtrace

if [ -z "${HOME}" ]
then
    echo "error: \$HOME undefined"
    exit 1
fi

FONTS_DIR=~/.local/share/fonts
install_fonts() {
	mkdir -p $FONTS_DIR
	nerd_fira_code_fonts_url=$(curl -L -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest|jq '.assets[] | select(.name == "FiraCode.zip") | .browser_download_url')
	curl -L -s -o /tmp/FiraCode.zip $nerd_fira_code_fonts_url
	unzip -o /tmp/FiraCode.zip -d $FONTS_DIR
}


DNF_PACKAGES="curl eza fzf git jq neovim powerline-go ripgrep tmux wezterm wl-clipboard"
install_packages() {
    sudo dnf copr enable wezfurlong/wezterm-nightly -y
    sudo dnf upgrade -y
    sudo dnf install -y $DNF_PACKAGES
}

__copy_dir_clean() {
    local src=$1
    local dst=$2
    rm -rf $dst
    cp -r $src $dst

}

copy_config_clean() {
    local src=".config/$1"
    local dst="$HOME/.config/$1"
    __copy_dir_clean $src $dst
}

if ! [[ "$1" == +(personal|bee) ]]
then
    echo "$0 personal|bee"
    exit 0
else
    ENV=$1
fi

install_fonts
install_packages

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# go
sudo dnf install golang -y
go env -w GOPATH=$HOME/.local/share/go

cp .bashrc $HOME
cp -r .bashrc.d $HOME
cp .bash_profile $HOME
cp .bash_logout $HOME
cp .tmux.conf $HOME
cp $ENV/.gitconfig $HOME

copy_config_clean nvim
copy_config_clean alacritty
copy_config_clean wezterm

cp -r .local/bin/ $HOME/.local
