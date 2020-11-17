#!/bin/bash

set -o xtrace

package_add()
{
    repo_url="$1"
    plugin_mode="$2"
    package_dir="$HOME/.vim/pack/plugins/$plugin_mode/$(basename $repo_url .git)"

    if [ -d "$package_dir" ]
    then
        echo Updating $package_dir
        git -C $package_dir pull --ff-only 1>/dev/null
    else
        echo Cloning $repo_url to $package_dir
        git clone $repo_url $package_dir 1>/dev/null
    fi

    echo Building helptags
    vim -u NONE -c "helptags $package_dir/doc" -c q
}

# Fedora packages:
sudo dnf install -y git vim fzf powerline-go powerline-fonts

# bash:
cp bashrc ~/.bashrc
cp bash_profile ~/.bash_profile

# vim:
cp vimrc ~/.vimrc
mkdir -p ~/.vim/files/{backup,undo,swap}

# vimplugins:
mkdir -p ~/.vim/pack/plugins/{start,opt}

package_add https://github.com/kaicataldo/material.vim opt
package_add https://github.com/itchyny/lightline.vim.git start
package_add https://github.com/preservim/nerdtree.git start
package_add https://github.com/vivien/vim-linux-coding-style.git start
package_add https://github.com/junegunn/fzf.vim.git start
package_add https://github.com/vim-syntastic/syntastic.git start
package_add https://github.com/pearofducks/ansible-vim.git start
package_add https://github.com/Vimjas/vim-python-pep8-indent.git start
package_add https://github.com/ntpeters/vim-better-whitespace start
package_add https://github.com/rust-lang/rust.vim start
