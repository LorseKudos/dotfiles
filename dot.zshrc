#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TZ=Asia/Tokyo

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
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

zstyle ':completion:*' completer _complete _expand _match _prefix _approximate _list
zstyle ':completion:*' list-separator '-->'
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd
# 中間ファイル等は補完しない
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# ps, kill コマンドのプロセス名補完
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*:processes' command 'ps -u $USER -o pid,stat,%cpu,%mem,cputime,command'


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

### alias ###
mkcd() {mkdir -p "$@" && cd "$*[-1]"}
mktmp() {mkdir `date +"%Y%m%d_%H%M%S"`}
t() {mkdir -p `dirname $1` && touch $1}

case ${OSTYPE} in
    darwin*)
        alias ls='ls -G'
        ;;
    linux*)
        alias ls='ls --color=auto'
        ;;
esac

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias sl=ls
alias ..='cd ..'
alias b='cd ..'
alias bb='cd ../..'
alias bbb='cd ../..'
alias mv='mv -i'
alias cp='cp -i'
alias c='clear'
alias cat='bat'
alias k='kubectl'
alias start_server='python -m SimpleHTTPServer 8080'

alias -g @g='| grep'
alias -g @x='| xargs'
alias -g @a='| awk'
alias -g @s='| sed'
alias -g @l='| less'
alias -g @h='| head'
alias -g @t='| tail'

### setopt ###
setopt list_packed
setopt list_types
setopt no_correct
setopt auto_menu            # タブで補完候補を表示する
setopt auto_cd              # ディレクトリ名のみ入力時、cdを適応させる
setopt auto_param_keys      # カッコの対応などを自動的に補完
setopt auto_param_slash     # ディレクトリ名の補完で末尾に/を自動的に付加
setopt complete_in_word     # 語の途中でもカーソル位置で補完
setopt equals               # =commandを`which command`と同じ処理
setopt interactive_comments # コマンドラインでの#以降をコメントと見なす
setopt list_packed          # 補完結果をできるだけ詰める
setopt noautoremoveslash    # 末尾から自動的に/を除かない
setopt nolistbeep           # 補完候補表示時にビープ音を鳴らさない
setopt notify              # バックグランドジョブが終了時知らせてくれる
setopt magic_equal_subst    # 引数での=以降も補完(--prefix=/usrなど)
setopt mark_dirs            # ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt print_eight_bit      # 日本語ファイル名を表示可能にする
setopt glob_complete        # globを展開しないで候補の一覧から補完する
setopt globdots             # 明確なドットの指定なしで.から始まるファイルをマッチ
setopt always_last_prompt   # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt list_rows_first      # 補完候補リストが垂直ではなく水平方向に並ぶようになる
setopt numeric_glob_sort    # ファイル名の展開で辞書順ではなく数値的にソート

### ヒストリー設定 ###
alias history='history -t "%m/%d %T" -D'
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
setopt hist_expand           # 補完時にヒストリを自動的に展開する。
setopt hist_verify           # ヒストリ呼び出しから、実行までの間に一度編集を可能にする

## 実行したプロセスの消費時間が3秒以上かかったら自動的に消費時間の統計情報を表示する。
REPORTTIME=3

## Ctrl+] で上の階層に移る
function cdup() {
    echo
    cd ..
    zle reset-prompt
}
zle -N cdup
bindkey '^]' cdup

### ssh-agent(WSL用) ###
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    eval `ssh-agent` > /dev/null
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zsh_profile

if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi
