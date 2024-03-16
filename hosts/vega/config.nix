# hosts/vega/config.nix
{
  inputs,
  pkgs,
  stateVersion,
  ...
}: let
  name = "vega";
in {
  sops.secrets."hosts/vega/ssh_key" = {
    owner = "root";
    path = "/root/.ssh/id_ed25519";
  };
  sops.secrets."hosts/vega/ssh_pubkey" = {
    owner = "root";
    path = "/root/.ssh/id_ed25519.pub";
  };

  services.udev.packages = [pkgs.yubikey-personalization];
  services.pcscd.enable = true;

  boot.supportedFilesystems = ["cifs"];
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  services.davfs2 = {
    enable = true;
    davUser = "juliuskoskela";
  };

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
  };

  nixpkgs.config = {
    allowUnfree = true;
    # HACK: Required by nixvim and Copilot, remove if Copilot is udpated
    # to use the new version of nodejs.
    permittedInsecurePackages = [
      "nodejs-16.20.0"
      "electron-25.9.0"
    ];
  };

  environment = {
    variables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  hardware = {
    bluetooth.enable = true;
    opengl.enable = true;
    opengl.driSupport32Bit = true;
    pulseaudio.enable = false;
  };

  services.desktopManager.plasma6.enable = true;

  services = {
    xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
    blueman.enable = true;
    printing.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    gnome.gnome-keyring.enable = true;
  };

  networking = {
    hostName = name;
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Helsinki";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fi_FI.UTF-8";
      LC_IDENTIFICATION = "fi_FI.UTF-8";
      LC_MEASUREMENT = "fi_FI.UTF-8";
      LC_MONETARY = "fi_FI.UTF-8";
      LC_NAME = "fi_FI.UTF-8";
      LC_NUMERIC = "fi_FI.UTF-8";
      LC_PAPER = "fi_FI.UTF-8";
      LC_TELEPHONE = "fi_FI.UTF-8";
      LC_TIME = "fi_FI.UTF-8";
    };
  };

  programs = {
    hyprland.enable = true;
    dconf.enable = true;
  };

  security = {
    pam.services.login.enableGnomeKeyring = true;
    rtkit.enable = true;
    polkit.enable = true;
  };

  sound.enable = true;
  system.stateVersion = stateVersion;
}
