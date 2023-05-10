{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.addons.barrier;

in
{
  options.constellation.desktop.addons.barrier = with types; {
    enable = mkBoolOpt false "Whether or not to enable Barrier.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      barrier
    ];

    networking.firewall.allowedTCPPorts = [
      24800
    ];

  };
}
