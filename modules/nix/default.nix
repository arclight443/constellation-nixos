{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.nix;
in
{
  options.constellation.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.nix "Which nix package to use.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      deploy-rs
      nixfmt
      nix-index
      nix-prefetch-git
    ];

    nix =
      let users = [ "root" config.constellation.user.name ];
      in
      {
        package = cfg.package;
        extraOptions = lib.concatStringsSep "\n" [
          ''
            experimental-features = nix-command flakes
            http-connections = 50
            warn-dirty = false
            log-lines = 50
            sandbox = relaxed
          ''
          (lib.optionalString (config.constellation.tools.direnv.enable) ''
            keep-outputs = true
            keep-derivations = true
          '')
        ];

        settings = {
          experimental-features = "nix-command flakes";
          http-connections = 50;
          warn-dirty = false;
          log-lines = 50;
          sandbox = "relaxed";
          auto-optimise-store = true;
          trusted-users = users;
          allowed-users = users;
        } // (lib.optionalAttrs config.constellation.tools.direnv.enable {
          keep-outputs = true;
          keep-derivations = true;
        });

        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 30d";
        };

        # flake-utils-plus
        generateRegistryFromInputs = true;
        generateNixPathFromInputs = true;
        linkInputs = true;
      };
  };
}
