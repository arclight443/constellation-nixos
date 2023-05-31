{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.apps.dbeaver;

in
{
  options.constellation.apps.dbeaver = with types; {
    enable = mkBoolOpt false "Whether or not to enable dbeaver.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dbeaver
    ];
  };
}
