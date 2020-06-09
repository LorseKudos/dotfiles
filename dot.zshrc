setopt PROMPT_SUBST
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash

GIT_PS1_SHOWDIRTYSTATE=true

if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# 出力の後に改行を入れる
precmd() { echo "" }


# default:cyan / root:red
if [ $UID -eq 0 ]; then
    PS1='%F{red}%*%f:%B%~%b%F{red}$(__git_ps1)%f
# '
else
    PS1='%F{cyan}%*%f:%B%~%b%F{red}$(__git_ps1)%f
$ '
fi

# "-F":ディレクトリに"/"を表示 / "-G"でディレクトリを色表示
alias ls='ls -FG'
alias ll='ls -alFG'

source ~/.zsh_profile
