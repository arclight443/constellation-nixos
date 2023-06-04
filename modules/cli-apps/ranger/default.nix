{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.cli-apps.ranger;

in
{
  options.constellation.cli-apps.ranger = with types; {
    enable = mkBoolOpt false "Whether or not to enable ranger.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ueberzugpp
      ranger
    ];

    constellation.home = {

      extraOptions = {
        home.packages = with pkgs; [
          ranger
          ueberzugpp
        ];
      };

      configFile."ranger/" =
        {
          source = ./config;
          recursive = true;
        };
    };
  };
}
