#!/bin/bash

# FIXME: need VIM >= 8.0, fzf

set -o xtrace

package_add()
{
    repo_url="$1"
    plugin_mode="$2"
    package_dir="$HOME/.vim/pack/plugins/$plugin_mode/$(basename $repo_url .git)"

    if [ -d "$package_dir" ]
    then
        echo Updating $package_dir
        git -C $package_dir pull 1>/dev/null
    else
        echo Cloning $repo_url to $package_dir
        git clone $repo_url $package_dir 1>/dev/null
    fi

    echo Building helptags
    vim -u NONE -c "helptags $package_dir/doc" -c q
}

# bash:
cp bashrc ~/.bashrc
cp bash_profile ~/.bash_profile

# liquidprompt:
if [ ! -d ~/.liquidprompt ]
then
    git clone https://github.com/nojhan/liquidprompt.git ~/.liquidprompt
else
    git -C ~/.liquidprompt pull
fi

# tilix
mkdir -p ~/.config/tilix/schemes
wget https://raw.githubusercontent.com/arcticicestudio/nord-tilix/develop/src/json/nord.json -O ~/.config/tilix/schemes/nord.json

# vim:
cp vimrc ~/.vimrc
mkdir -p ~/.vim/files/{backup,undo,swap}

# vimplugins:
mkdir -p ~/.vim/pack/plugins/{start,opt}

package_add https://github.com/arcticicestudio/nord-vim opt
package_add https://github.com/itchyny/lightline.vim.git start
package_add https://github.com/preservim/nerdtree.git start
package_add https://github.com/vivien/vim-linux-coding-style.git start
package_add https://github.com/junegunn/fzf.vim.git start
package_add https://github.com/vim-syntastic/syntastic.git start
package_add https://github.com/pearofducks/ansible-vim.git start
package_add https://github.com/Vimjas/vim-python-pep8-indent.git start
package_add https://github.com/ntpeters/vim-better-whitespace start
package_add https://github.com/rust-lang/rust.vim start
