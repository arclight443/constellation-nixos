{ pkgs, lib, ... }:

pkgs.fetchFromGitHub {
  owner = "lcpz";
  repo = "awesome-freedesktop";
  rev = "c82ad2960c5f0c84e765df68554c266ea7e9464d";
  sha256 = "0jw0p8hl4f5jdcjpafhyg0z2p9ypj2629h0wwqnqalfgqh4js2wm";
  name = "awesome-freedesktop";
}
