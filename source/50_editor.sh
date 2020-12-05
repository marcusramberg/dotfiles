# Editing

export BAT_THEME="Dracula"
alias less="bat"
alias cat="bat"
alias q='nvim'
alias vi='vim'
type nvim &> /dev/null && alias vim=nvim
if [[ -z "$SSH_TTY" ]]; then
  export EDITOR='nvim'
  export LESSEDIT='nvim'
else
  export EDITOR=$(type nvim vim vi nano pico 2>/dev/null | sed 's/ .*$//;q')
  alias q="\$EDITOR -w -z"
fi

export VISUAL="$EDITOR"

alias q.='q .'

qs() {
  pwd | perl -ne"s#^$(echo ~/.dotfiles)## && exit 1" && cd ~/.dotfiles
  q ~/.dotfiles
}
