# Install
source ~/.dotfiles/install-packages.sh

# Add configuration symlinks
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig

# Link .bashrc
echo "source ~/.dotfiles/bash/.bashrc" > ~/.bash_profile
