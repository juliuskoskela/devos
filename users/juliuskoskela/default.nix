# users/juliuskoskela/default.nix
{
  inputs,
  utils,
  pkgs,
  ...
}: let
  gitUser = utils.mkGitUser {
    username = "juliuskoskela";
    email = "julius.koskela@nordic-dev.net";
    gpgKey = "5A7B7F4897C2914B";
  };
in {
  imports = with inputs; [
    nixvim.homeManagerModules.nixvim
    nix-colors.homeManagerModules.default
    plasma-manager.homeManagerModules.plasma-manager
    sops-nix.homeManagerModules.sops
    gitUser
  ];

  sops = {
    age.keyFile = "/home/juliuskoskela/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/secrets.yaml;
  };

  sops.secrets."users/juliuskoskela/ssh_key" = {
    path = "/home/juliuskoskela/.ssh/id_rsa";
  };

  sops.secrets."users/juliuskoskela/ssh_key.pub" = {
    path = "/home/juliuskoskela/.ssh/id_rsa.pub";
  };

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
