#!/bin/bash

set -o xtrace

if [ -z "${HOME}" ]
then
    echo "error: \$HOME undefined"
    exit 1
fi

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

# wezterm
sudo dnf copr enable wezfurlong/wezterm-nightly -y
sudo dnf install wezterm

# brew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install eza fzf gcc git neovim ripgrep rustup golang
brew install --cask font-fira-code-nerd-font

rustup default stable
rustup-init -y
go env -w GOPATH=$HOME/.local/share/go

cp .bashrc $HOME
cp -r .bashrc.d $HOME
cp .bash_profile $HOME
cp .bash_logout $HOME
cp $ENV/.gitconfig $HOME

copy_config_clean nvim
copy_config_clean wezterm

cp -r .local/bin/ $HOME/.local
