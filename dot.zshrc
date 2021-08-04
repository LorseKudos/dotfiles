setopt PROMPT_SUBST
source ~/.zsh/git-prompt.sh
source ~/.zsh/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

# git-completionの読み込み
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
autoload -Uz compinit && compinit

# プロンプトのオプション表示設定
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

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

function mkcd(){
    if [[ -d $1 ]]; then
        cd $1
    else
        mkdir -p $1 && cd $1
    fi
}

### alias ###
case ${OSTYPE} in
    darwin*)
        alias ls='ls -G'
        ;;
    linux*)
        alias ls='ls --color=auto'
        ;;
esac

# "-F":ディレクトリに"/"を表示 / "-G"でディレクトリを色表示
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias sl=ls
alias ..='cd ..'
alias b='cd ..'
alias bb='cd ../..'
alias bbb='cd ../..'
alias c='clear'
alias cat='bat'

### ヒストリー設定 ###
HISTFILE=~/.zsh_history      # ヒストリファイルを指定
HISTSIZE=10000               # ヒストリに保存するコマンド数
SAVEHIST=10000               # ヒストリファイルに保存するコマンド数
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt share_history         # コマンド履歴ファイルを共有する
setopt append_history        # 履歴を追加
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks    # 余分な空白は詰めて記録
zstyle ':completion:*:default' menu select

# コマンドを途中まで入力後、historyから絞り込み
# 例 ls まで打ってCtrl+pでlsコマンドをさかのぼる、Ctrl+bで逆順
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^b" history-beginning-search-forward-end

setopt interactive_comments

### ssh-agent(WSL用) ###
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    eval `ssh-agent` > /dev/null
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

source ~/.zsh_profile
