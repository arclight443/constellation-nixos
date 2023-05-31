{ pkgs, lib, ... }:

pkgs.fetchFromGitHub {
  owner = "BlingCorp";
  repo = "bling";
  rev = "401985a327797cf146d95789f83421beeda8a27e";
  sha256 = "181frkysb5g8n2d7xprnmqgyra05h061a847n0rfwjdj3g8p6qks";
  name = "bling";
}
