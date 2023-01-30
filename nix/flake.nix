{
  description = "mBook";

  inputs = {
    # Package sets
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;

    # Environment/system management
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    # nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    # Other sources
    comma.url = github:nix-community/comma;
    devenv.url = "github:cachix/devenv/v0.2";



  };

  outputs = { self, darwin, nixpkgs, home-manager, devenv, ... } @inputs:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (inputs.nixpkgs-unstable.lib) attrValues optionalAttrs singleton;


      # Configuration for `nixpkgs`
      nixpkgsConfig = {
        config = { allowUnfree = true; };
        /* overlays = attrValues self.overlays ++ singleton ( */
        /*   # Sub in x86 version of packages that don't build on Apple Silicon yet */
        /*   final: prev: (optionalAttrs (prev.stdenv.system == "aarch64-darwin") { */
        /*     inherit (final.pkgs-x86) */
        /*       idris2 */
        /*       nix-index */
        /*       devenv */
        /*       niv; */
        /*   }) */
        /* ); */
      };
    in
    {
      # My `nix-darwin` configs

      darwinConfigurations.mbook = darwinSystem {
        system = "aarch64-darwin";
        modules = attrValues self.darwinModules ++ [
          # Main `nix-darwin` config
          ./configuration.nix
          # `home-manager` module
          home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgsConfig;
            # inherit nix-doom-emacs;
            # `home-manager` config
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.marcus = import ./home.nix;
          }
        ];
      };


      darwinModules = {
        programs-nix-index =
          # Additional configuration for `nix-index` to enable `command-not-found` functionality with Fish.
          { config, lib, pkgs, ... }:

          {
            config = lib.mkIf config.programs.nix-index.enable {
              programs.fish.interactiveShellInit = ''
                function __fish_command_not_found_handler --on-event="fish_command_not_found"
                  ${if config.programs.fish.useBabelfish then ''
                  command_not_found_handle $argv
                  '' else ''
                  ${pkgs.bashInteractive}/bin/bash -c \
                    "source ${config.programs.nix-index.package}/etc/profile.d/command-not-found.sh; command_not_found_handle $argv"
                  ''}
                end
              '';
            };
          };
      };
    };
}
