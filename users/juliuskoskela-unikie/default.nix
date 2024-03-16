# users/juliuskoskela-unikie/default.nix
{
  inputs,
  utils,
  pkgs,
  colors,
  ...
}: let
  gitUser = utils.mkGitUser {
    username = "juliuskoskela-unikie";
    email = "julius.koskela@unikie.com";
    gpgKey = "D5C22DF4D8242BBE";
  };

  dotfiles = import ../../programs {
    inherit (inputs) hyprland hyprwm-contrib;
    inherit pkgs colors;
  };
in {
  imports = with inputs; [
    nixvim.homeManagerModules.nixvim
    nix-colors.homeManagerModules.default
    plasma-manager.homeManagerModules.plasma-manager
    sops-nix.homeManagerModules.sops
    hyprland.homeManagerModules.default
    gitUser
    dotfiles.alacritty
    dotfiles.hyprland
    dotfiles.nixvim
    dotfiles.plasma
    dotfiles.waybar
  ];

  fonts.fontconfig.enable = true;

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };

    nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
  };
}
