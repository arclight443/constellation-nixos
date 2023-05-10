{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.apps.tor-browser;

in
{
  options.constellation.apps.tor-browser = with types; {
    enable = mkBoolOpt false "Whether or not to enable TOR browser.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tor-browser-bundle-bin
    ];
  };
}
