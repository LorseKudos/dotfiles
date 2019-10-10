#!/bin/bash

# dotfileをホームディレクトリにリンク
for f in dot.??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == "dot.brewfile" ]] && continue

    echo "${f:3}"
    ln -s $HOME/Dropbox/dotfiles/$f $HOME/${f:3}
done

# # brewをリストア
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
brew bundle install --file=dot.brewfile
