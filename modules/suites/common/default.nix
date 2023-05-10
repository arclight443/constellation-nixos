{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.suites.common;
in
{
  options.constellation.suites.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {

    constellation = {
      nix = enabled;

      cli-apps = {
        #flake = enabled;
      };

      tools = {
        git = enabled;
        misc = enabled;
        bottom = enabled;
      };

      hardware = {
        audio = enabled;
        storage = enabled;
        networking = enabled;
      };

      security = {
        doas = enabled;
        keyring = enabled;
      };

      system = {
        boot = enabled;
        fonts = enabled;
        locale = enabled;
        time = enabled;
        xkb = enabled;
      };
    };
  };
}
