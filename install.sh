# Install
sudo apt install -y \
  git \
  stow \
  tree \
  wget \
  zsh

# Add configuration symlinks
stow git
stow powerlevel10k
stow zsh

# Add zsh as a login shell and set as default shell
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER

# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
