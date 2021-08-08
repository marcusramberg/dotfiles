# No welcome necessary
set -U fish_greeting
# Dracula
set fish_theme dracula
if status is-interactive
    # Commands to run in interactive sessions can go here
    alias vi nvim
    alias cat bat
    abbr l ls
    #git
    abbr gc git commit
    abbr gs git status
    abbr gp git pull
    abbr gd git diff
end

# Make it vim
fish_vi_key_bindings


test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

