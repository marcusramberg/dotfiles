# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "~/.nix-profile/share/fzf/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source ~/.nix-profile/share/fzf/key-bindings.zsh
