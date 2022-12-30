sudo apt install -y \
  git \
  stow \
  tree \
  wget \
  zsh

stow git
stow zsh

# Add zsh as a login shell and set as default shell
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER