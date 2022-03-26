
curl --create-dirs -o ~/.zsh/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
curl --create-dirs -o ~/.zsh/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl --create-dirs -o ~/.zsh/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
curl --create-dirs -o ~/.zsh/zsh-autosuggestions.zsh https://raw.githubusercontent.com/zsh-users/zsh-autosuggestions/master/zsh-autosuggestions.zsh

if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    sudo ln -s '/mnt/c/Program Files/Docker/Docker/resources/bin/docker-credential-desktop.exe' /usr/local/bin/docker-credential-desktop.exe
    sudo ln -s '/mnt/c/Users/Lorse/AppData/Local/Programs/Microsoft VS Code/bin/code' /usr/local/bin/code
    sudo ln -s '/mnt/c/Windows/explorer.exe' /usr/local/bin/open
    sudo ln -s '/mnt/c/Windows/System32/clip.exe' /usr/local/bin/pbcopy
fi

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# dotfileをホームディレクトリにリンク
for f in dot.??*
do
    [[ "$f" == "dot.brewfile" ]] && continue
    [[ "$f" == "dot.gitignore" ]] && continue

    echo "${f:3}"
    ln -sf $HOME/.dotfiles/$f $HOME/${f:3}
done

# gitignoreは ~/.config/git/ignore に置く
echo ".gitignore"
mkdir -p $HOME/.config/git && ln -sf $HOME/.dotfiles/dot.gitignore $HOME/.config/git/ignore

# brew bundle install --file=dot.brewfile
