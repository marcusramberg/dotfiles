# Linux-only stuff. Abort if not Linux 
[[ "$(uname)" =~ Linux ]] || return 1

export PATH=~/.dotfiles/bin/linux:$PATH

eval $(dircolors ~/.dircolors)
alias xc=xclip -selection c
alias icat="kitty +kitten icat"
alias pai="pamac install"
alias pas="pamac search"
export BROWSER='firefox-developer-edition'
GPG_TTY=$(tty)
export GPG_TTY
source /usr/share/doc/find-the-command/ftc.zsh

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin:~/.emacs.d/bin/
alias icat="kitty +kitten icat"
alias pai="pamac install"
alias pas="pamac search"
export BROWSER='firefox-developer-edition'
GPG_TTY=$(tty)
export GPG_TTY
source /usr/share/doc/find-the-command/ftc.zsh

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin:~/.emacs.d/bin/

