#!/bin/bash

set -o xtrace

# Fedora packages:
sudo dnf install -y alacritty tmux git neovim fzf powerline-go powerline-fonts nodejs

# bash:
cp bashrc ~/.bashrc
cp bash_profile ~/.bash_profile

# nvim:
cp -r .config/nvim ~/.config/

# alacritty
cp -r .config/alacritty ~/.config/

# tmux
cp .tmux.conf ~/
