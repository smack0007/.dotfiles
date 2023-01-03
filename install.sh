__SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd $__SCRIPTDIR

# Install
source ~/.dotfiles/install-packages.sh

# Add configuration symlinks
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc

# Add zsh as a login shell and set as default shell
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
rm ~/.zshrc
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc

popd
unset __SCRIPTDIR