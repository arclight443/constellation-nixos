{
  description = "Arclight's NixOS configuration. Constructed using Jake Hamilton's snowfall-lib";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake = {
      url = "github:snowfallorg/flake";
      inputs.nixpkgs.follows = "unstable";
    };

    neovim = {
      url = "github:arclight443/constellation-neovim";
      inputs.nixpkgs.follows = "unstable";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    };

    arkenfox = {
      url = "github:dwarfmaster/arkenfox-nixos";
    };

    chrome-pwa = {
      url = "github:luis-hebendanz/nixos-chrome-pwa";
    };

  };

  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;
      };
    in

    lib.mkFlake {
      package-namespace = "constellation";
      channels-config.allowUnfree = true;

      overlays = with inputs; [
        #  neovim.overlay
      ];

      systems.modules = with inputs; [
        home-manager.nixosModules.home-manager
        chrome-pwa.nixosModule
      ];

    };
}
