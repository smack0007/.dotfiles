# Install
# source ~/.dotfiles/install-packages.sh

# Add configuration symlinks
git config --global include.path "~/.dotfiles/git/.gitconfig"

# Link kitty config
mkdir -p ~/.config/kitty && echo 'include ~/.dotfiles/.config/kitty/kitty.conf' > ~/.config/kitty/kitty.conf

# Link .bashrc
echo "source ~/.dotfiles/bash/.bashrc" > ~/.bash_profile
echo "source ~/.dotfiles/bash/.bashrc" > ~/.bashrc

# Link .zshrc
echo "source ~/.dotfiles/zsh/.zshrc" > ~/.zprofile
echo "source ~/.dotfiles/zsh/.zshrc" > ~/.zshrc
