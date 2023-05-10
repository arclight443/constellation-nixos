{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.addons.gtk;

in
{
  options.constellation.desktop.addons.gtk = with types; {
    enable = mkBoolOpt false "Whether or not to enable gtk theme.";
  };

  config = mkIf cfg.enable {

    programs.dconf.enable = true;
    constellation.home.extraOptions = {

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

    environment.variables = {
      GTK_THEME = "gruvbox-dark";
    };

  };
}
