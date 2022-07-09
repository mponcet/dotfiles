#!/bin/bash

set -o xtrace

cp .bashrc ~/
cp -r .bashrc.d ~/
cp .bash_profile ~/
cp .bash_logout ~/

cp -r .config/nvim ~/.config/

cp -r .config/alacritty ~/.config/

cp .tmux.conf ~/
