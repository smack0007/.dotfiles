source ~/.dotfiles/terminal/functions.sh
source ~/.dotfiles/terminal/aliases.sh

if is_msys; then
  # MSYS2 doesn't add VS Code to the path
  if [[ ! ":$PATH:" == *":/c/Program Files/Microsoft VS Code/bin:"* ]]; then
    PATH="$PATH:/c/Program Files/Microsoft VS Code/bin"
  fi
fi

# WSL adds the entire PATH from windows to the local PATH so just cut the fat
if is_wsl; then
  PATH=$(sed ':a; N; $!ba; s/\n/:/g' ~/.dotfiles/terminal/wsl.path)
fi

export NODE_PREFIX="$HOME/.node"
export PATH="$NODE_PREFIX/bin:$PATH"

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

[ -f ~/.ssh/github_ed25519 ] && eval $(ssh-agent) &>/dev/null && ssh-add ~/.ssh/github_ed25519 &>/dev/null
