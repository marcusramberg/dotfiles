# Ubuntu-only stuff. Abort if not Ubuntu.
[[ "$(uname)" =~ Linux ]] || return 1

export PATH=~/.dotfiles/bin/linux:$PATH

eval $(dircolors ~/.dircolors)
