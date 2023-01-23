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

