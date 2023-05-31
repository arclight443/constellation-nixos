{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.utils.dconf;

in
{
  options.constellation.desktop.utils.dconf = with types; {
    enable = mkBoolOpt false "Whether or not to enable dconf and dconf-editor.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gnome.dconf-editor
    ];

  };
}
