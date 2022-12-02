# No welcome necessary
set -U fish_greeting
# Dracula
set fish_theme dracula
if status is-interactive
    # Commands to run in interactive sessions can go here
    alias cat bat
    alias ag rg
    alias r "cd (git root)"
    function rd
        fd $argv (git root)
    end
    alias emacs "emacs -nw"
    alias imgcat "wezterm imgcat"
    abbr l ls
    thefuck --alias | source
    #git
    abbr gc git commit
    abbr gs git status
    abbr gsu git status -uno
    abbr gp git pull
    abbr gb git branch
    abbr gd git diff
    abbr gwa git  worktree add
    abbr gwl git  worktree list
    abbr gwr git  worktree remove
    abbr gl git log
    abbr vi nvim
    abbr gfu "git fetch --all --prune && git rebase origin/main"
    abbr .. cd ..
    abbr ... cd ../..
    abbr .... cd ../../..
    abbr k kubectl 
    abbr kx kubectx
end

# Make it vim
fish_vi_key_bindings
set -gx EDITOR nvim


test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

status --is-interactive; and . (~/.plenv/bin/plenv init -|psub)

# Completion
eval (kustomize completion fish)
yq shell-completion fish | source

# set --universal pure_color_mute 777
# set --universal pure_enable_single_line_prompt true

fish_add_path /.dotfiles/bin /usr/local/sbin 
fish_add_path -a /run/current_system/sw/bin ~/.local/bin /opt/homebrew/bin ~/go/bin/ ~/.nimble/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/marcus/google-cloud-sdk/path.fish.inc' ]; . '/Users/marcus/google-cloud-sdk/path.fish.inc'; end

set CLOUDSDK_PYTHON_SITEPACKAGES 1
#set SSH_AUTH_SOCK "${XDG_RUNTIME_DIR}/ssh-agent.socket"

if status is-login
    if [ -f /Users/marcus/.ssh/id_rsa ]
        ssh-add --apple-use-keychain  ~/.ssh/id_rsa
        ssh-add --apple-use-keychain  ~/.ssh/id_dsa
        ssh-add --apple-use-keychain  ~/.ssh/google_compute_engine
    end
end
nvm use
source tide_config.fish
