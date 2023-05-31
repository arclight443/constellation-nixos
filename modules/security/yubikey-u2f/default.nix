{ options, config, pkgs, lib, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.security.yubikey-u2f;
in
{
  options.constellation.security.yubikey-u2f = {
    enable = mkBoolOpt false "Whether or not to enable yubikey u2f auth.";
  };

  config = mkIf cfg.enable {
    security.pam.services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
  };
}
