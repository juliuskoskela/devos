# programs/default.nix
{
  # hyprland,
  hyprwm-contrib,
  pkgs,
  colors,
  ...
}: let
  alacritty = import ./alacritty {inherit colors;};
  hyprland = import ./hyprland {inherit hyprwm-contrib pkgs colors;};
  nixvim = import ./nixvim {inherit pkgs;};
  waybar = import ./waybar {inherit pkgs colors;};
  plasma = import ./plasma {inherit pkgs colors;};
  zsh = import ./zsh {inherit pkgs;};
in {
  inherit alacritty hyprland nixvim waybar plasma zsh;
}
