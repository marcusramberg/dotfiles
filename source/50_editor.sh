# Editing

export BAT_THEME="Nord"
alias less="bat"
alias cat="bat"
alias q='nvim'
alias vi='emacs -nw'
type nvim &> /dev/null && alias vim=nvim
if [[ ! -n "$SSH_TTY" ]]; then
  export EDITOR='emacs -nw'
  export LESSEDIT='emacs -nw %f'
else
  export EDITOR=$(type emacsclient nvim vim vi nano pico 2>/dev/null | sed 's/ .*$//;q')
  alias q="$EDITOR -w -z"
fi

export VISUAL="$EDITOR"

alias q.='q .'

function qs() {
  pwd | perl -ne"s#^$(echo ~/.dotfiles)## && exit 1" && cd ~/.dotfiles
  q ~/.dotfiles
}
