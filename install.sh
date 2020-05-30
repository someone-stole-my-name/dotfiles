#!/usr/bin/env bash

HOME_FILES="
.Xresources
.bash_exports
.bash_functions
.bashrc
.fonts
.tmux.conf
.urxvt
.vimrc
"

ENCRYPTED_HOME_FILES="
.bash_bbva
"

for file in ${HOME_FILES}; do
    rm -rf ~/${file}
    ln -s ~/git/dotfiles/${file} ~/${file}
done

read -e -s -p "Enter passphrase: " PASSPHRASE
for file in ${ENCRYPTED_HOME_FILES}; do
    rm -rf ~/${file}
    gpg --passphrase ${PASSPHRASE} --decrypt ${file} > ~/${file}
done

