{ pkgs, lib, ... }:

pkgs.fetchFromGitHub {
  owner = "Drauthius";
  repo = "awesome-sharedtags";
  rev = "47fbce14337600124d49d33eb2476b5ed96a966c";
  sha256 = "15sds1vbh49glz4afyx7x9ppf85daznqwdp8msl1qfl858r932pd";
  name = "awesome-sharedtags";
}
