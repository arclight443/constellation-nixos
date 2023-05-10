{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.tools.direnv;
in
{
  options.constellation.tools.direnv = with types; {
    enable = mkBoolOpt false "Whether or not to enable direnv.";
  };

  config = mkIf cfg.enable {
    constellation.home.extraOptions = {
      programs.direnv = {
        enable = true;
        nix-direnv = enabled;
      };
    };
  };
}
