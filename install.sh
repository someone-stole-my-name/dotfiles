#!/usr/bin/env bash

HOME_FILES="
.vimrc
.tmux.conf
.Xresources
"

for file in ${HOME_FILES}; do
    rm -rf ~/${file}
    ln -s ~/git/dotfiles/${file} ~/${file}
done
