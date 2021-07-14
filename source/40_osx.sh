# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
PATH=/usr/local/bin:$(path_remove /usr/local/bin)
PATH=/usr/local/sbin:$(path_remove /usr/local/sbin)
PATH=~/.dotfiles/bin/osx:$(path_remove ~/.dotfiles/bin/osx)
PATH=~/.emacs.d/bin:$(path_remove ~/.emacs.d/bin)
export PATH

export GOPATH=/Users/marcus/gocode
export GOROOT=$(echo /usr/local/Cellar/go/*/libexec)
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
#eval "$(jenv init - --no-rehash)"
#export PATH="$HOME/.jenv/bin:$PATH"

# Try to find jenv, if it's not on the path
export JENV_ROOT="${JENV_ROOT:=${HOME}/.jenv}"
if ! type jenv > /dev/null && [ -f "${JENV_ROOT}/bin/jenv" ]; then
    export PATH="${JENV_ROOT}/bin:${PATH}"
fi

# Lazy load jenv
if type jenv > /dev/null; then
    export PATH="${JENV_ROOT}/bin:${JENV_ROOT}/shims:${PATH}"
    function jenv() {
        unset -f jenv
        eval "$(command jenv init -)"
        jenv $@
    }
fi



# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Fix open with
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'


# Make 'less' more.
eval "$(lesspipe.sh)"

function zle-keymap-select zle-line-init zle-line-finish {
  case $KEYMAP in
    vicmd)      print -n -- "\E]50;CursorShape=0\C-G";; # block cursor
    viins|main) print -n -- "\E]50;CursorShape=1\C-G";; # line cursor
  esac

  zle reset-prompt
  zle -R
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

#eval $(gdircolors ~/.dircolors)

source "`brew --prefix`/etc/grc.bashrc"

