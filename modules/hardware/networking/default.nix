{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.hardware.networking;
in
{
  options.constellation.hardware.networking = with types; {
    enable = mkBoolOpt false "Whether or not to enable networking support";
    hosts = mkOpt attrs { }
      "An attribute set to merge with <option>networking.hosts</option>";
  };

  config = mkIf cfg.enable {
    constellation.user.extraGroups = [ "networkmanager" ];

    networking = {
      hosts = {
        "127.0.0.1" = [ "local.test" ] ++ (cfg.hosts."127.0.0.1" or [ ]);
      } // cfg.hosts;

      networkmanager = {
        enable = true;
        dhcp = "internal";
      };

      firewall = {
        enable = true;
      };

    };

    # Fixes an issue that normally causes nixos-rebuild to fail.
    # https://github.com/NixOS/nixpkgs/issues/180175
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
