#!/bin/bash

curl -o ~/.zsh/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
curl -o ~/.zsh/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o ~/.zsh/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh


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
