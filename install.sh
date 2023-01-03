__SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
pushd $__SCRIPTDIR

# TODO: Abstract out software installation.

# Install
sudo apt install -y \
  curl \
  file \
  gcc \
  git \
  gnupg \
  libsdl2-dev \
  lsb-release \
  make \
  software-properties-common \
  tree \
  unzip \
  wget \
  zsh

# clang
sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 100 
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 100

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

# deno
curl -fsSL https://deno.land/x/install/install.sh | sh

# Add configuration symlinks
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/powerlevel10k/.p10k.zsh ~/.p10k.zsh
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc

# Add zsh as a login shell and set as default shell
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER

# powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

popd
unset __SCRIPTDIR