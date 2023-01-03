# See https://gist.github.com/fworks/af4c896c9de47d827d4caa6fd7154b6b to install zsh

ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/powerlevel10k/.p10k.zsh ~/.p10k.zsh
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc

mkdir -p ~/.config/git
echo "" > ~/.config/git/git-prompt.sh