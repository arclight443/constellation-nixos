{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.desktop.utils.fcitx5;

in
{
  options.constellation.desktop.utils.fcitx5 = with types; {
    enable = mkBoolOpt false "Whether or not to enable fcitx5.";
  };

  config = mkIf cfg.enable {
    constellation.home = {
      extraOptions = {
        home.packages = with pkgs; [
          fcitx5-mozc
        ];

        i18n.inputMethod = {
          enabled = "fcitx5";
          fcitx5.addons = with pkgs; [ fcitx5-mozc ];
        };
      };

      file."themes" = {
        source = ./themes;
        target = "${config.users.users.${config.constellation.user.name}.home}/.local/share/fcitx5/themes";
        recursive = true;
      };

      configFile = {
        "fcitx5/conf/classicui.conf".source = ./config/conf/classicui.conf;
      };
    };

  };
}
