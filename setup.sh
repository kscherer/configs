#!/bin/bash

backup_dir="$HOME/.backup"

function make_link() {
    if [ -e "$HOME/.$1" ]; then
        mv "$HOME/.$1" "$backup_dir"
    fi
    ln -s "$PWD/$1" "$HOME/.$1"
}
mkdir -p $backup_dir
make_link bashrc
make_link aliases
make_link gitconfig
make_link tmux.conf

if [ -e "$HOME/.emacs.d" ]; then
    mv $HOME/.emacs.d $HOME/.emacs.d.backup
fi

mkdir -p $HOME/.emacs.d/backup
ln -s $PWD/emacs.d/emacs_config $HOME/.emacs.d/
ln -s $PWD/emacs.d/packages $HOME/.emacs.d/
ln -s $PWD/emacs.d/org $HOME/.emacs.d/
ln -s $PWD/emacs.d/init.el $HOME/.emacs.d/init.el
ln -s $PWD/emacs.d/snippets $HOME/.emacs.d/
