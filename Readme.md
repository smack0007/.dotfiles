## Installation

### Git Bash

```shell
eval $(ssh-agent) && ssh-add ~/.ssh/github_ed25519
git clone git@github.com:smack0007/.dotfiles.git ~/.dotfiles
sh ~/.dotfiles/scripts/git-bash-get-zsh.sh
# Copy zsh into Git Bash by hand
sh ~/.dotfiles/install-git-bash.sh
```

Windows Termnial:
```json
{
  "commandline": "\"%PROGRAMFILES%\\Git\\usr\\bin\\zsh.exe\" --login -i -l",
  "guid": "{2ece5bfe-50ed-5f3a-ab87-5cd4baafed2b}",
  "hidden": false,
  "icon": "%PROGRAMFILES%\\Git\\mingw64\\share\\git\\git-for-windows.ico",
  "name": "Git Bash",
  "startingDirectory": "D:\\"
},
```

### WSL 

```
wsl --update
wsl --shutdown
```

### WSL Debian

```
wsl --install Debian
sudo apt install git
git clone git@github.com:smack0007/.dotfiles.git ~/.dotfiles
```

### Common

```
sh ./install.sh
```

