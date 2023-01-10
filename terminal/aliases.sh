alias dotfiles-cd="cd ~/.dotfiles"
alias dotfiles-code="code ~/.dotfiles"
alias dotfiles-gitex="pushd ~/.dotfiles > /dev/null && gitex && popd > /dev/null"
alias dotfiles-install-packages="sh ~/.dotfiles/install-packages.sh"
alias dotfiles-pull="pushd ~/.dotfiles > /dev/null && git pull && popd > /dev/null"
alias dotfiles-status="pushd ~/.dotfiles > /dev/null && git status -s && popd > /dev/null"

function dotfiles-push() {
    pushd ~/.dotfiles > /dev/null
    git add -A && git commit -m "$1" && git push origin main
    popd > /dev/null
}

function e() {
  if [[ is_msys || is_wsl ]]; then
    explorer.exe $1
  else
    xdg-open $1
  fi
  true
}

function gitex() {
  if [[ is_msys || is_wsl ]]; then
    gitex.cmd $1
    true
  else
    echo "gitex not implemented."
    false
  fi  
}

alias ll='ls -lA --color'

function mcd() {
    mkdir -p $1
    cd $1
}

function winpath() {
  if [[ is_msys ]]; then
    cygpath --absolute --long-name --windows $1
  else
    echo "winpath not implemented."
    false
  fi
}