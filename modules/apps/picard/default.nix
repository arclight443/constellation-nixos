{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.apps.picard;
in
{
  options.constellation.apps.picard = with types; {
    enable = mkBoolOpt false "Whether or not to enable Picard.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      picard
    ];

  };
}
