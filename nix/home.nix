{ config, pkgs, lib, ... }:
{
  home.stateVersion = "22.05";
  # imports = [ nix-doom-emacs.hmModule ];


  # https://github.com/malob/nixpkgs/blob/master/home/default.nix

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop = {
    enable = true;
    settings.show_program_path = true;
  };

  #  programs.doom-emacs = {
  #    enable = true;
  #    doomPrivateDir = ./doom.d; # Directory containing your config.el, init.el
  #    # and packages.el files
  #  };
  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = "fortune art goedel wisdom tao literature songs-poems paradoxum; echo ''";
      rd = "fd $argv (git root)";
    };
    shellAbbrs = {
      l = "ls";
      gc = "git commit";
      gs = "git status";
      gsu = "git status -uno";
      gp = "git pull";
      gb = "git branch";
      gd = "git diff";
      gwa = "git  worktree add";
      gwl = "git  worktree list";
      gwr = "git  worktree remove";
      gl = "git log";
      vi = "nvim";
      gfu = "git fetch --all --prune && git rebase origin/main";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      k = "kubectl ";
      kx = "kubectx";
      kns = "kubens";
    };
    shellAliases = {
      cat = "bat";
      ls = "exa";
      ag = "rg";
      emacs = "emacs -nw";
      r = "cd (git root)";
      imgcat = "wezterm imgcat";
    };
    shellInit = ''
      fish_add_path /.dotfiles/bin /usr/local/sbin 
      fish_add_path -a /run/current_system/sw/bin ~/.local/bin /opt/homebrew/bin ~/go/bin/ ~/.nimble/bin
      set CLOUDSDK_PYTHON_SITEPACKAGES 1
    '';
    interactiveShellInit = ''
      fish_vi_key_bindings
      set fish_theme  tokyo-night
      set -gx EDITOR nvim
      type -q thefuck; and thefuck --alias | source
      test -x ~/.plenv/bin/plenv; and . (~/.plenv/bin/plenv init -|psub)
      if [ -f '/Users/marcus/google-cloud-sdk/path.fish.inc' ]; . '/Users/marcus/google-cloud-sdk/path.fish.inc'; end

      # Completion
      type -q kustomize; and eval (kustomize completion fish)
      type -q yq; and yq shell-completion fish | source
      type -q nvm; and nvm use -s

      source ~/.config/fish/tide_config.fish
    '';
    loginShellInit = ''
      if [ -f /Users/marcus/.ssh/id_rsa ]
        ssh-add -q --apple-use-keychain  ~/.ssh/id_rsa
        ssh-add -q --apple-use-keychain  ~/.ssh/id_dsa
        ssh-add -q --apple-use-keychain  ~/.ssh/google_compute_engine
      end
      set -x GPG_TTY (tty)
      gpgconf --launch gpg-agent
    '';
  };
  programs.atuin.enable = true;
  programs.fzf.enable = true;
  programs.keychain.enable = true;
  programs.navi.enable = true;
  programs.zoxide.enable = true;

  home.packages = with pkgs; [
    actionlint
    bat
    cocogitto
    coreutils
    curl
    exa
    deadnix
    git
    git-crypt
    fd
    fortune
    go
    golangci-lint
    gopls
    jq
    nodePackages.typescript
    nodePackages.node2nix
    nodejs-16_x
    neovim-unwrapped
    ripgrep
    tealdeer
    wget
    yq-go

    # useful nix related tools
    cachix # adding/managing alternative binary caches hosted by cachix
    comma # run software from without installing it
    niv # easy dependency management for nix projects
  ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
  ];

}

