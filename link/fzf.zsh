# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "~/.dotfiles/conf/fzf-completion.zsh" 2> /dev/null

# Key bindings
# ------------
source ~/.dotfiles/conf/fzf-key-bindings.zsh
