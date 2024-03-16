# hosts/vega/default.nix
{
  inputs,
  pkgs,
  stateVersion,
  ...
}: {
  imports = [
    ./config.nix
    ./hardware.nix
    ./packages.nix
    ./builders.nix
  ];
}
