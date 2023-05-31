{ pkgs, lib, ... }:

pkgs.fetchFromGitHub {
  owner = "streetturtle";
  repo = "awesome-wm-widgets";
  rev = "c8388f484e72c8eaef2d9562b2dc1ff293518782";
  sha256 = "16vygnhvahg8dpbb7v4al2wgkpa3077vyx4vfmqcn167hqkfpynl";
  name = "awesome-wm-widgets";
}
