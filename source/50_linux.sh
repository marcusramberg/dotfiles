# Linux-only stuff. Abort if not Linux 
[[ "$(uname)" =~ Linux ]] || return 1

export PATH=~/.dotfiles/bin/linux:$PATH

eval $(dircolors ~/.dircolors)
alias xc=xclip -selection c
