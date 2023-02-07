source ~/.dotfiles/terminal/aliases.sh
source ~/.dotfiles/terminal/functions.sh

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

[ -f ~/.ssh/github_ed25519 ] && eval $(ssh-agent) &>/dev/null && ssh-add ~/.ssh/github_ed25519 &>/dev/null
