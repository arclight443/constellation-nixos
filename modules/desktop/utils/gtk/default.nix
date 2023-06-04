{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.utils.gtk;
  env = {
    GTK_THEME = "gruvbox-dark";
  };
  envUpscaled = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
  };

in
{
  options.constellation.desktop.utils.gtk = with types; {
    enable = mkBoolOpt false "Whether or not to enable gtk theme.";
    uiScaling = mkOpt (enum [ "normal" "enlarged" ]) "normal" "UI scaling to use (enlarged configuration for 14 inch laptop).";

  };

  config = mkIf cfg.enable {

    programs.dconf.enable = true;

    constellation.home.extraOptions = {

      home.packages = with pkgs; [
        gtk4
      ];

      gtk = {
        enable = true;
        theme = {
          name = "gruvbox-dark";
          package = pkgs.gruvbox-dark-gtk;
        };
        iconTheme = {
          name = "oomox-gruvbox-dark";
          package = pkgs.gruvbox-dark-icons-gtk;
        };
        gtk3.extraConfig = {
          Settings = ''
            gtk-application-prefer-dark-theme=1
          '';
        };
        gtk4.extraConfig = {
          Settings = ''
            gtk-application-prefer-dark-theme=1
          '';
        };
      };
    };

    environment.variables =
      if cfg.uiScaling == "enlarged"
      then
        env // envUpscaled
      else
        env;

  };
}
