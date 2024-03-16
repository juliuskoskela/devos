# programs/default.nix
{
  pkgs,
  colors,
  ...
}: let
  alacritty = import ./alacritty { inherit colors; };
  hyprland = import ./hyprland { inherit colors; };
  nixvim = import ./nixvim { inherit pkgs; };
  waybar = import ./waybar { inherit colors; };
  plasma = import ./plasma { inherit pkgs colors; };
in {
  inherit alacritty hyprland nixvim waybar plasma;
}
