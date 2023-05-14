inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.cli-apps.chatblade;
in
{
  options.constellation.cli-apps.chatblade = with types; {
    enable = mkBoolOpt false "Whether or not to enable chatblade.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      chatblade
    ];
  };
}
