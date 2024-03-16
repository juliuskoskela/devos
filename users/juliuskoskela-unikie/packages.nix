# users/juliuskoskela-unikie/packages.nix
{pkgs, ...}:
with pkgs; [
  nushell # Shell
  firefox # Default browser
  tea # Gitea CLI
  vscode # Visual Studio Code
  obsidian # Note taking
  zathura # PDF viewer
  mattermost-desktop # Open source chatroom client
  zulip # Open source chatroom client
  slack # Proprietary chatroom client
  discord # Proprietary chatroom client
  whatsapp-for-linux # Whatsapp client
  jdk19 # Java development kit
  perl # Perl
  rustup # Rust
  pandoc # Document converter
  unzip # Unzip utility
  drone-cli # Drone CI
  gh # Github CLI
  curl # URL transfer utility
  wget # URL transfer utility
  nixpkgs-fmt # Nix formatter
  hardinfo # System information
  appimage-run # AppImage runner
  ripgrep # Search utility
  fd # Search utility
  blueman # Bluetooth manager
  minicom # Terminal serial port manager
  usbutils # USB utilities
  nmap # Network scanner
  alsa-lib # Audio library
  alsa-tools # Audio tools
  alsa-utils # Audio utilities
  dtc # Device tree compiler
  putty # SSH client
  nftables # Firewall
  dnsmasq # DNS server
  deploy-rs # Deployment tool
  jq # JSON processor
  bison # Parser generator
  flex # Lexical analyser
  quilt # Patch manager
  nushell # Shell
  htop # Process viewer
  btop # Process viewer
  neofetch # System information
  inetutils # Telnet client
  spotify # Music streaming
  pcscliteWithPolkit
  yubikey-manager # Yubikey manager
  yubikey-personalization
  yubikey-personalization-gui
  age-plugin-yubikey
  yubikey-touch-detector
  gnupg # GPG encryption
  keeweb # Password manager
  sops # Encrypted file editor
  audacity # Audio editor

  (nerdfonts.override {
    fonts = [
      "FiraCode"
      "DroidSansMono"
      "JetBrainsMono"
    ];
  })
]
