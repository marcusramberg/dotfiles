# Ubuntu-only stuff. Abort if not Ubuntu.
[[ "$(uname)" =~ Linux ]] || return 1

Package management
export PATH=~/.dotfiles/bin/linux:$PATH
