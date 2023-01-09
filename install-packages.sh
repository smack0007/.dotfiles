source ~/.dotfiles/terminal/functions.sh

DISTRO=$(get_distro)
PACKAGES=$(sed ':a; N; $!ba; s/\n/ /g' ~/.dotfiles/${DISTRO}.packages)

case ${DISTRO} in
  "debian")
    sudo apt install -y ${PACKAGES}
    ;;
  
  "fedora")
    sudo dnf install -y ${PACKAGES}
    ;;
esac

# TODO: See if we can detect and then reinstall
# clang
# sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
# sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 100 
# sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 100

# node
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

# deno
# curl -fsSL https://deno.land/x/install/install.sh | sh