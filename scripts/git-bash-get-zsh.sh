#!/bin/sh
mkdir -p ~/Downloads/zsh
pushd ~/Downloads/zsh

curl -L https://github.com/facebook/zstd/releases/download/v1.5.2/zstd-v1.5.2-win64.zip > zstd.zip
unzip zstd.zip
rm zstd.zip
mv zstd-*/ zstd/

curl -L https://mirror.msys2.org/msys/x86_64/zsh-5.9-2-x86_64.pkg.tar.zst > zsh.tar.zst
zstd/zstd.exe -d ./zsh.tar.zst
tar xvf zsh.tar
rm zsh.tar.zst zsh.tar
rm -rf zstd/

explorer.exe .
explorer.exe "C:\Program Files\Git"

popd