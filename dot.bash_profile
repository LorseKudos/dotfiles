export PATH=$HOME/.nodebrew/current/bin:$PATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(rbenv init -)"
eval "$(nodenv init -)"

export GOPATH=$HOME/go
export GOENV_ROOT=$HOME/.goenv
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH=$PATH:$GOPATH/bin

export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
export PATH=$HOME/.composer/vendor/bin:$PATH
eval "$(direnv hook bash)"

export PATH=$HOME/flutter/bin:$PATH
