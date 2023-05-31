{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.suites.development;
  apps = {
    insomnia = enabled;
    dbeaver = enabled;
  };
  cli-apps = {
    tmux = enabled;
    neovim = enabled;
  };
in
{
  options.constellation.suites.development = with types; {
    enable = mkBoolOpt false
      "Whether or not to enable common development configuration.";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [
      12345
      3000
      3001
      8080
      8081
    ];

    constellation = {
      inherit apps cli-apps;

      tools = {
        direnv = enabled;
        http = enabled;
      };

    };
  };
}
