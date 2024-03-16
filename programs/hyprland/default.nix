# programs/hyprland/default.nix
{
  # hyprland,
  hyprwm-contrib,
  pkgs,
  colors,
  ...
}: {
  # imports = [
  #   hyprland.homeManagerModules.default
  # ];

  home.packages = with pkgs; [
    hyprwm-contrib.packages.${system}.grimblast
    swaybg
    swayidle
    wofi
    mako
    swww
    # TODO Is this needed?
    # hyprland.packages.${system}.xdg-desktop-portal-hyprland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # package = hyprland.packages.${pkgs.system}.default;
    extraConfig = import ./config.nix {
      inherit colors;
    };
  };
}
