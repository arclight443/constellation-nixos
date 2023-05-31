{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.security.age;
in
{
  options.constellation.security.age = with types; {
    enable = mkBoolOpt false "Whether to enable age.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      age
    ];
  };
}
