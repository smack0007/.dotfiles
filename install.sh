# Install
# source ~/.dotfiles/install-packages.sh

# Add configuration symlinks
git config --global include.path "~/.dotfiles/git/.gitconfig"

# Link .bashrc
echo "source ~/.dotfiles/bash/.bashrc" > ~/.bash_profile
echo "source ~/.dotfiles/bash/.bashrc" > ~/.bashrc

# Link .zshrc
echo "source ~/.dotfiles/zsh/.zshrc" > ~/.zprofile
echo "source ~/.dotfiles/zsh/.zshrc" > ~/.zshrc
