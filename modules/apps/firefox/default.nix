{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.internal;

let
  cfg = config.constellation.apps.firefox;
  icons = "${pkgs.numix-icon-theme}/share/icons/Numix/scalable";
  arkenfox = import ./arkenfox.nix { inherit lib; };

  extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
    tridactyl
    ublock-origin
    privacy-redirect
    multi-account-containers
    xbrowsersync
    darkreader
    i-dont-care-about-cookies
    don-t-fuck-with-paste
  ];

  search = {
    default = "DuckDuckGo";
    force = true;
    engines = {

      "Nix Packages" = {
        urls = [{
          template = "https://search.nixos.org/packages";
          params = [
            { name = "type"; value = "packages"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@np" ];
      };

      "Nix Options" = {
        urls = [{
          template = "https://search.nixos.org/options";
          params = [
            { name = "type"; value = "options"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@no" ];
      };

      "Bing".metaData.hidden = true;
      "Google".metaData.hidden = true;

    };
  };

  profiles = {

    "Personal" = {
      inherit extensions search;
      default = true;
      icon = "${icons}/categories/applications-games-symbolic.svg";
      arkenfox = [
        arkenfox.main
        {
          "0100"."0102"."browser.startup.page".value = 3;
          "0100"."0103"."browser.startup.homepage".value = "https://duckduckgo.com/?kae=d&kak=-1&kao=-1&kaq=-1&ks=m&kw=n&ko=d&kau=-1&kax=-1&k1=-1&kk=-1&kaj=m&kap=-1&kad=en_US&kz=1&kav=-1&kt=Hack+Nerd+Font&kn=1&k7=282828&kj=3c3836&km=l&kaa=83a598&k18=1&k21=504945&q=";
        }
      ];
    };

    "Media" = {
      inherit extensions search;
      icon = "${icons}/categories/applications-multimedia-symbolic.svg";
      arkenfox = [
        arkenfox.main
        {
          "0100"."0102"."browser.startup.page".value = 3;
          "0100"."0103"."browser.startup.homepage".value = "https://duckduckgo.com/?kae=d&kak=-1&kao=-1&kaq=-1&ks=m&kw=n&ko=d&kau=-1&kax=-1&k1=-1&kk=-1&kaj=m&kap=-1&kad=en_US&kz=1&kav=-1&kt=Hack+Nerd+Font&kn=1&k7=282828&kj=3c3836&km=l&kaa=83a598&k18=1&k21=504945&q=";
        }
      ];
    };

    "Work" = {
      inherit extensions search;
      icon = "${icons}/categories/applications-education-symbolic.svg";
      arkenfox = [
        arkenfox.main
        {
          "0100"."0102"."browser.startup.page".value = 3;
          "0100"."0103"."browser.startup.homepage".value = "https://duckduckgo.com/?kae=d&kak=-1&kao=-1&kaq=-1&ks=m&kw=n&ko=d&kau=-1&kax=-1&k1=-1&kk=-1&kaj=m&kap=-1&kad=en_US&kz=1&kav=-1&kt=Hack+Nerd+Font&kn=1&k7=282828&kj=3c3836&km=l&kaa=83a598&k18=1&k21=504945&q=";
        }
      ];
    };

    "Services" = {
      inherit extensions search;
      icon = "${icons}/emblems/emblem-system-symbolic.svg";
      arkenfox = [
        arkenfox.main
        {
          "0100"."0102"."browser.startup.page".value = 1;
          "0100"."0103"."browser.startup.homepage".value = "https://duckduckgo.com/?kae=d&kak=-1&kao=-1&kaq=-1&ks=m&kw=n&ko=d&kau=-1&kax=-1&k1=-1&kk=-1&kaj=m&kap=-1&kad=en_US&kz=1&kav=-1&kt=Hack+Nerd+Font&kn=1&k7=282828&kj=3c3836&km=l&kaa=83a598&k18=1&k21=504945&q=";
        }
      ];
    };

    "Private" = {
      inherit extensions search;
      icon = "${icons}/emotes/emote-love-symbolic.svg";
      arkenfox = [
        arkenfox.main
        {
          "0100"."0102"."browser.startup.page".value = 1;
          "0100"."0103"."browser.startup.homepage".value = "https://duckduckgo.com/?kae=d&kak=-1&kao=-1&kaq=-1&ks=m&kw=n&ko=d&kau=-1&kax=-1&k1=-1&kk=-1&kaj=m&kap=-1&kad=en_US&kz=1&kav=-1&kt=Hack+Nerd+Font&kn=1&k7=282828&kj=3c3836&km=l&kaa=83a598&k18=1&k21=504945&kp=-2&q=";
          "1200"."1201"."security.ssl.require_safe_negotiation".value = false;
        }
        arkenfox.safe
      ];
    };

    "Secure" = {
      inherit extensions search;
      icon = "${icons}/status/security-high-symbolic.svg";
      arkenfox = [
        arkenfox.main
        {
          "0100"."0102"."browser.startup.page".value = 1;
          "0100"."0103"."browser.startup.homepage".value = "https://duckduckgo.com/?kae=d&kak=-1&kao=-1&kaq=-1&ks=m&kw=n&ko=d&kau=-1&kax=-1&k1=-1&kk=-1&kaj=m&kap=-1&kad=en_US&kz=1&kav=-1&kt=Hack+Nerd+Font&kn=1&k7=282828&kj=3c3836&km=l&kaa=83a598&k18=1&k21=504945&q=";
        }
        arkenfox.hardened
      ];
    };

  };


  buildProfile = id: name: profile: {
    acc = id + 1;
    value = {
      inherit name id;
      settings =
        {
          "browser.uidensity" = "compact";
          "browser.rememberSignons" = false; # Disable password manager
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.aboutwelcome.enabled" = false;
          "browser.meta_refresh_when_inactive.disabled" = true;
          "ui.key.menuAccessKeyFocuses" = false;
        }
        // (
          if profile ? settings
          then profile.settings
          else { }
        );
      isDefault =
        if profile ? default
        then profile.default
        else false;

      userChrome = ''
        @import "${pkgs.constellation.firefox-cascade}/chrome/userChrome.css";
      '';

      extensions =
        if profile ? extensions
        then profile.extensions
        else false;

      search =
        if profile ? search
        then profile.search
        else { };

      arkenfox = lib.mkMerge ([
        {
          enable = true;
        }
      ]
      ++ (
        if profile ? arkenfox
        then profile.arkenfox
        else [ ]
      ));

    };
  };


  # rofi-script = pkgs.writeScript "rofi-firefox" (''
  #   if test "$#" -eq 1; then
  #       coproc (${config.programs.firefox.package}/bin/firefox "$URL_TO_OPEN" -P "$@" > /dev/null 2>&1)
  #       exit 0
  #   fi
  # ''
  # + concatMapStrings (profile: "echo \"${profile.name}\"\n") (attrNameValuePairs profiles));

  buildDesktop = name: profile: ''
    [Desktop Entry]
    Name=Firefox - ${name}
    Exec=/etc/profiles/per-user/${config.constellation.user.name}/bin/firefox -P "${name}"
    Type=Application
    Terminal=False
    Icon=${profile.icon}
  '';


in
{
  options.constellation.apps.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable Firefox.";
  };

  config = mkIf cfg.enable {

    programs.firefox.nativeMessagingHosts.tridactyl = true;

    constellation.home = {

      file.".tridactylrc".source = ./.tridactylrc;

      extraOptions = {
        programs.firefox = {
          enable = true;
          package = pkgs.firefox.override (
            {
              cfg = {
                enableTridactylNative = true;
              };
            }
          );

          arkenfox = {
            enable = true;
            version = "master";
          };

          profiles = foldOverAttrs 0 buildProfile profiles;

        };

        xdg.dataFile =
          mapAttrs'
            (name: profile: nameValuePair "applications/firefox-${name}.desktop" { text = buildDesktop name profile; })
            profiles;
        #          // {
        #            "applications/firefox-launcher.desktop".text = ''
        #              [Desktop Entry]
        #              Name=Web Browser
        #              Exec=${launcher}/bin/firefox-launcher
        #              Type=Application
        #              Terminal=False
        #              Icon=firefox
        #            '';
        #          };

        #home.packages = [
        #  launcher
        #];
      };
    };
  };
}
