{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.apps.microsoft-edge;

in
{
  options.constellation.apps.microsoft-edge = with types; {
    enable = mkBoolOpt false "Whether or not to enable microsoft-edge.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      microsoft-edge-stable
    ];
  };
}
