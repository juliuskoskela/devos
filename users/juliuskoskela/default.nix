# users/juliuskoskela/default.nix
{
  inputs,
  utils,
  pkgs,
  colors,
  ...
}: let
  gitUser = utils.mkGitUser {
    username = "juliuskoskela";
    email = "julius.koskela@nordic-dev.net";
    gpgKey = "5A7B7F4897C2914B";
  };

  dotfiles = import ../../programs {inherit pkgs colors;
    # hyprland = inputs.hyprland;
    hyprwm-contrib = inputs.hyprwm-contrib;
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
