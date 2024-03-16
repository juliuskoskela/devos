# programs/plasma/default.nix
{
  pkgs,
  colors,
  ...
}: {
  programs.plasma = {
    enable = true;
    workspace = {
      clickItemTo = "select";
      tooltipDelay = 5;
      theme = "otto";
      colorScheme = "Otto";
    };
  };
}
