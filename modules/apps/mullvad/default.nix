{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.apps.mullvad;
in
{
  options.constellation.apps.mullvad = with types; {
    enable = mkBoolOpt false "Whether or not to enable mullvad vpn.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mullvad
    ];

    services.mullvad-vpn.enable = true;
  };
}
