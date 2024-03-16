# programs/alacritty/default.nix
{colors, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "JetBrains Mono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrains Mono Nerd Font";
          style = "Bold";
        };
        size = 12;
      };
      colors = with colors.palette; {
        primary = {
          background = "#${base00}";
          foreground = "#${base05}";
        };
        normal = {
          black = "#${base00}";
          red = "#${base08}";
          green = "#${base0B}";
          yellow = "#${base0D}";
          blue = "#${base0E}";
          magenta = "#${base0C}";
          cyan = "#${base0A}";
          white = "#${base05}";
        };
      };
    };
  };
}
