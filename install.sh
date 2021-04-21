#!/bin/bash

set -o xtrace

# Fedora packages:
sudo dnf install -y git neovim fzf powerline-go powerline-fonts nodejs

# bash:
cp bashrc ~/.bashrc
cp bash_profile ~/.bash_profile

# nvim:
cp -r .config/nvim ~/.config/
