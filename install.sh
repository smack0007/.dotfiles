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
  stow \
  tree \
  unzip \
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

# clang
sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 100 
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 100

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

# deno
curl -fsSL https://deno.land/x/install/install.sh | sh