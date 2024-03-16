# hosts/vega/packages.nix
{pkgs, ...}: let
  packages = with pkgs; [
    keyd
    python3
    nodejs
    wget
    curl
    pkg-config
    openssl
    helix
    efibootmgr
    nixpkgs-fmt
    cliphist
    gnupg
    ssh-to-pgp
    protonmail-bridge
    hdparm
    pciutils
    pavucontrol
    davfs2
    gvfs
    udisks2
  ];
in {
  environment.systemPackages = packages;
}
