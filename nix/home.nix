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
  programs.fish = import ./home/fish.nix { inherit pkgs; };
  programs.fzf = {
    enable = true;
    tmux.enableShellIntegration = true;
  };
  programs.keychain.enable = true;
  programs.navi.enable = true;
  programs.zoxide.enable = true;

  programs.tmux = {
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    enable = true;
    keyMode = "vi";
    prefix = "`";
    secureSocket = false; # survives user logout
    terminal = "tmux-256color";
    tmuxinator.enable = true;
    extraConfig = ''
      set -ga terminal-overrides ",*256col*:Tc"
      set -g set-titles on
      set -g set-titles-string "#I > #T"
      set -g status-style bg=white,fg=black
      set -g mode-style bg=white,fg=black
      set -g message-style bg=white,fg=black
      set -g message-command-style bg=white,fg=black
      set -g status off
      set -g display-time 1000
      set-window-option -g visual-bell on
      set-window-option -g bell-action other
    '';
  };

  home.packages = with pkgs; [
    actionlint
    asciinema
    bat
    cargo
    cocogitto
    coreutils
    curl
    exa
    deadnix
    git
    git-crypt
    fd
    fortune
    gnumake
    go
    golangci-lint
    gopls
    go-task
    gotestfmt
    grc
    jq
    nodePackages.typescript
    nodePackages.node2nix
    nodejs-16_x
    neovim-unwrapped
    pssh
    (import ./home/python.nix { inherit pkgs; })
    ripgrep
    tealdeer
    thefuck
    wget
    yq-go

    # useful nix related tools
    /* cachix # adding/managing alternative binary caches hosted by cachix */
    /* comma # run software from without installing it */
    /* niv # easy dependency management for nix projects */
  ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
  ];

}

