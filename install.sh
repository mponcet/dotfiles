#!/bin/bash

set -o xtrace

link() {
  mkdir -p "$(dirname "$2")"
  if [ -e "$2" ]
  then
    echo "Skipping $2, already exists."
  else
    ln -sf "$1" "$2"
    echo "Linked $1 to $2"
  fi
}

if [ -z "${HOME}" ]
then
    echo "error: \$HOME undefined"
    exit 1
fi

# wezterm
sudo dnf copr enable wezfurlong/wezterm-nightly -y
sudo dnf install wezterm

# brew
sudo dnf group install development-tools
sudo dnf install procps-ng curl file
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install  \
    bitwarden-cli \
    eza \
    fzf \
    gcc \
    git \
    golang \
    gopass \
    neovim \
    ripgrep \
    rustup \
    tree-sitter
brew install --cask font-fira-code-nerd-font

rustup default stable
rustup-init -y
go env -w GOPATH=$HOME/.local/share/go

link $PWD/.bashrc $HOME/.bashrc
link $PWD/.bashrc.d $HOME/.bashrc.d
link $PWD/personal/.gitconfig $HOME/.gitconfig

link $PWD/.config/nvim $HOME/.config/nvim
link $PWD/.config/wezterm $HOME/.config/wezterm
link $PWD/.config/opsline $HOME/.config/opsline

cp -r .local/bin/ $HOME/.local
