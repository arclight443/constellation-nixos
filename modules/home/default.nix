{ options, config, pkgs, lib, inputs, ... }:

with lib;
with lib.internal;
let cfg = config.constellation.home;
in
{
  imports = with inputs; [
    home-manager.nixosModules.home-manager
  ];

  options.constellation.home = with types; {
    file = mkOpt attrs { }
      "A set of files to be managed by home-manager's <option>home.file</option>.";
    configFile = mkOpt attrs { }
      "A set of files to be managed by home-manager's <option>xdg.configFile</option>.";
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
  };

  config = {
    constellation.home.extraOptions = {

      imports = [ inputs.arkenfox.hmModules.default inputs.hyprland.homeManagerModules.default ];

      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.constellation.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.constellation.home.configFile;
    };

    home-manager = {
      useUserPackages = true;

      users.${config.constellation.user.name} =
        mkAliasDefinitions options.constellation.home.extraOptions;


    };
  };
}
