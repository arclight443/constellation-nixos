{ inputs, options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.wayland.waybar;

in
{
  options.constellation.desktop.wayland.waybar = with types; {
    enable = mkBoolOpt false "Whether or not to enable waybar.";
  };

  config = mkIf cfg.enable {
    constellation.home.extraOptions = {
      programs.waybar = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.waybar-hyprland;
      };
    };
  };
}
