{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.desktop.utils.onboard;
in
{
  options.constellation.desktop.utils.onboard = with types; {
    enable = mkBoolOpt false "Whether or not to enable Onboard (on-screen keyboard utility for tablet PCs).";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      onboard
    ];

    constellation.home.file."onboard" = {
      source = ./onboard;
      target = "${config.users.users.${config.constellation.user.name}.home}/.local/share/onboard";
      recursive = true;
    };

  };
}
