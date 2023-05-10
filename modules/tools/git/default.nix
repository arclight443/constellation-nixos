{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.tools.git;
  gpg = config.constellation.security.gpg;
  user = config.constellation.user;
in
{
  options.constellation.tools.git = with types; {
    enable = mkBoolOpt false "Whether or not to install and configure git.";
    userName = mkOpt types.str user.fullName "The name to configure git with.";
    userEmail = mkOpt types.str user.email "The email to configure git with.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ git ];

    constellation.home.extraOptions = {
      programs.git = {
        enable = true;
        inherit (cfg) userName userEmail;
        extraConfig = {
          init = { defaultBranch = "main"; };
        };
      };
    };
  };
}
