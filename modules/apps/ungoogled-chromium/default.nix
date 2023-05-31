{ options, config, lib, pkgs, ... }:

with lib;
with lib.internal;
let
  cfg = config.constellation.apps.ungoogled-chromium;

in
{
  options.constellation.apps.ungoogled-chromium = with types; {
    enable = mkBoolOpt false "Whether or not to enable ungoogled-chromium.";
  };

  config = mkIf cfg.enable {
    constellation.home.extraOptions = {

      programs.chromium = {
        enable = true;
        package = pkgs.ungoogled-chromium;
        extensions =
          let
            createChromiumExtensionFor = browserVersion: { id, sha256, version }:
              {
                inherit id;
                crxPath = builtins.fetchurl {
                  url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
                  name = "${id}.crx";
                  inherit sha256;
                };
                inherit version;
              };
            createChromiumExtension = createChromiumExtensionFor (lib.versions.major pkgs.ungoogled-chromium.version);
          in
          [
            (createChromiumExtension {
              # ublock origin
              id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
              sha256 = "sha256:0qfphf8abzvy9cng8112zzbs9vsnbdqwjwywigk8nrgh4pignvb1";
              version = "1.49.2";
            })
            (createChromiumExtension {
              # line
              id = "ophjlpahpchlmihnnnihgmmeilfjmjjc";
              sha256 = "sha256:0jvs0958vk793g2draxdhsbsfv222axnhz5xg8acln7hpli4vp2r";
              version = "2.5.13";
            })
          ];
      };
    };
  };
}
