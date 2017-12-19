# Editing

if [[ ! -n "$SSH_TTY" ]]; then
  export EDITOR='nvim'
  export LESSEDIT='nvim %f'
  alias q='nvim'
  alias vi='vim'
 type nvim &> /dev/null && alias vim=nvim
else
  export EDITOR=$(type nvim vim vi nano pico 2>/dev/null | sed 's/ .*$//;q')
  alias q="$EDITOR -w -z"
fi

export VISUAL="$EDITOR"

alias q.='q .'

function qs() {
  pwd | perl -ne"s#^$(echo ~/.dotfiles)## && exit 1" && cd ~/.dotfiles
  q ~/.dotfiles
}
