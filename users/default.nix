# users/default.nix
{
  inputs,
  utils,
  pkgs,
  programs,
  stateVersion,
  ...
}: let
  juliuskoskela = utils.mkUser {
    inherit stateVersion;

    username = "juliuskoskela";
    description = "Julius Koskela's personal user";
    extraGroups = ["networkmanager" "wheel" "dialout" "davfs2" "storage"];

    homeConfig = import ./juliuskoskela {inherit inputs utils pkgs;};
    packages = import ./juliuskoskela/packages.nix {inherit pkgs;};

    imports = [
      programs.alacritty
      programs.hyprland
      programs.nixvim
      programs.plasma
      programs.waybar
    ];
  };

  juliuskoskela-unikie = utils.mkUser {
    inherit stateVersion;

    username = "juliukoskela-unikie";
    description = "Julius Koskela's user for Unikie";
    extraGroups = ["networkmanager" "wheel" "dialout" "davfs2" "storage"];

    homeConfig = import ./juliuskoskela-unikie {inherit inputs utils pkgs;};
    packages = import ./juliuskoskela-unikie/packages.nix {inherit pkgs;};

    imports = [
      programs.alacritty
      programs.hyprland
      programs.nixvim
      programs.plasma
      programs.waybar
    ];
  };
in {
  inherit juliuskoskela juliuskoskela-unikie;
}
