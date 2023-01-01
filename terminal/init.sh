source ~/.dotfiles/terminal/aliases.sh
source ~/.dotfiles/terminal/functions.sh

# WSL adds the entire PATH from windows to the local PATH so just cut the fat
[ is_wsl ] && PATH=$(sed ':a; N; $!ba; s/\n/:/g' ~/.dotfiles/terminal/wsl.path)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

[ -f "~/.ssh/github_ed25519" ] && eval $(ssh-agent) && ssh-add ~/.ssh/github_ed25519