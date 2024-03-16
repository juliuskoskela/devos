# hosts/vega/hardware.nix
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fcf6a2c5-e9e1-426c-88a4-bb2a687ae8e0";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2651-564E";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/b333d325-7b2b-4d9a-986f-49c9dc6f405d";}
  ];

  fileSystems."/mnt/ssd-1" = {
    device = "/dev/disk/by-uuid/92314744-e47f-4c02-be66-3af0feb6a8d7";
    fsType = "ext4";
  };

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp9s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
