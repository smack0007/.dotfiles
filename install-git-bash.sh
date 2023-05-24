#!/bin/sh

# Link .gitconfig
git config --global include.path "$(cygpath --absolute --long-name --windows ~/.dotfiles/git/.gitconfig)"

# Link .bashrc
echo "source ~/.dotfiles/bash/.bashrc" > ~/.bash_profile

# Get rid of error related to being unable to load bash completions
mkdir -p ~/.config/git
echo "" > ~/.config/git/git-prompt.sh