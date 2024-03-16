# users/default.nix
{
  inputs,
  utils,
  pkgs,
  colors,
  stateVersion,
  ...
}: let
  juliuskoskela = utils.mkUser {
    inherit stateVersion;

    username = "juliuskoskela";
    description = "Julius Koskela's personal user";
    extraGroups = ["networkmanager" "wheel" "dialout" "davfs2" "storage"];

    homeConfig = import ./juliuskoskela {inherit inputs utils pkgs colors;};
    packages = import ./juliuskoskela/packages.nix {inherit pkgs;};
  };

  juliuskoskela-unikie = utils.mkUser {
    inherit stateVersion;

    username = "juliukoskela-unikie";
    description = "Julius Koskela's user for Unikie";
    extraGroups = ["networkmanager" "wheel" "dialout" "davfs2" "storage"];

    homeConfig = import ./juliuskoskela-unikie {inherit inputs utils pkgs colors;};
    packages = import ./juliuskoskela-unikie/packages.nix {inherit pkgs;};
  };
in {
  inherit juliuskoskela juliuskoskela-unikie;
}
