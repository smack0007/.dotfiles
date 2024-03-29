## Installation

### Fedora

```
sudo dnf install redhat-lsb
# Copy .ssh keys into WSL
chmod 600 ~/.ssh/github_ed25519*
eval $(ssh-agent) && ssh-add ~/.ssh/github_ed25519
git clone git@github.com:smack0007/.dotfiles.git ~/.dotfiles
```

### Git Bash

```shell
eval $(ssh-agent) && ssh-add ~/.ssh/github_ed25519
git clone git@github.com:smack0007/.dotfiles.git ~/.dotfiles
sh ~/.dotfiles/install-git-bash.sh
```

Windows Termnial:

```json
{
  "commandline": "\"%PROGRAMFILES%\\Git\\usr\\bin\\bash.exe\" --login -i -l",
  "guid": "{2ece5bfe-50ed-5f3a-ab87-5cd4baafed2b}",
  "hidden": false,
  "icon": "%PROGRAMFILES%\\Git\\mingw64\\share\\git\\git-for-windows.ico",
  "name": "Git Bash",
  "startingDirectory": "D:\\"
},
```

### MacOS

```shell
git config --global include.path "~/.dotfiles/git/.gitconfig"
echo "source $HOME/.dotfiles/zsh/.zshrc" > ~/.zshrc
```

### MSYS2

`nano /etc/nsswitch.conf` and set `db_home: windows`

```json
{
  "commandline": "C:/msys64/msys2_shell.cmd -defterm -here -no-start -mingw64",
  "guid": "{71160544-14d8-4194-af25-d05feeac7233}",
  "hidden": false,
  "name": "MinGW64",
  "icon": "C:/msys64/msys2.ico",
  "startingDirectory": "D:\\"
}
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

# Copy .ssh keys into WSL
chmod 600 ~/.ssh/github_ed25519*
eval $(ssh-agent) && ssh-add ~/.ssh/github_ed25519
git clone git@github.com:smack0007/.dotfiles.git ~/.dotfiles
```

### WSL Fedora

```
# https://dev.to/bowmanjd/install-fedora-on-windows-subsystem-for-linux-wsl-4b26

# Get rootfs
docker run --name fedora fedora:37
docker export -o "C:\WSL\fedora-rootfs.tar" fedora
docker stop fedora
docker rm fedora

# Import fedora
wsl --import fedora "C:\WSL\fedora" "C:\wsl\fedora-rootfs.tar"
wsl -d fedora

dnf upgrade -y
dnf install passwd sudo -y

passwd root

useradd zachary
passwd zachary
usermod -aG wheel zachary

echo '[user]' >> /etc/wsl.conf
echo 'default=zachary' >> /etc/wsl.conf

# From windows
wsl --terminate fedora
rm D:\WSL\fedora-rootfs.tar
wsl --set-default fedora

# Back in fedora
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/c/Windows:/mnt/c/Program Files/Microsoft VS Code/bin"
sudo dnf install -y git openssh nano net-tools redhat-lsb stow wget which zsh

# Copy .ssh keys into WSL
chmod 600 ~/.ssh/github_ed25519*
eval $(ssh-agent) && ssh-add ~/.ssh/github_ed25519
git clone git@github.com:smack0007/.dotfiles.git ~/.dotfiles
```

### Common

```
sh ./install.sh
```
