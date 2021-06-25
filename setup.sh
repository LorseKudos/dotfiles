#!/bin/bash

# dotfileをホームディレクトリにリンク
for f in dot.??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == "dot.brewfile" ]] && continue

    echo "${f:3}"
    ln -s $HOME/.dotfiles/$f $HOME/${f:3}
done

# brew bundle install --file=dot.brewfile
