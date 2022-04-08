# No welcome necessary
set -U fish_greeting
# Dracula
set fish_theme dracula
if status is-interactive
    # Commands to run in interactive sessions can go here
    alias cat bat
    alias ag rg
    alias emacs "emacs -nw"
    abbr l ls
    thefuck --alias | source
    #git
    abbr gc git commit
    abbr gs git status
    abbr gsu git status -uno
    abbr gp git pull
    abbr gb git branch
    abbr gd git diff
    abbr gl git log
    abbr vi nvim
    abbr k kubectl 
end

# Make it vim
fish_vi_key_bindings
set -gx EDITOR nvim


test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

status --is-interactive; and . (~/.plenv/bin/plenv init -|psub)

eval (kustomize completion fish)

fish_add_path ~/.dotfiles/bin /usr/local/ltex-ls/bin
fish_add_path /usr/local/sbin ~/.local/bin /opt/homebrew/bin ~/go/bin/

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/marcus/google-cloud-sdk/path.fish.inc' ]; . '/Users/marcus/google-cloud-sdk/path.fish.inc'; end

set CLOUDSDK_PYTHON_SITEPACKAGES 1
