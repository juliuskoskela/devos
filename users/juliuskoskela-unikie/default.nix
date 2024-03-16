# users/juliuskoskela-unikie/default.nix
{
  inputs,
  utils,
  pkgs,
  ...
}: let
  gitUser = utils.mkGitUser {
    username = "juliuskoskela-unikie";
    email = "julius.koskela@unikie.com";
    gpgKey = "D5C22DF4D8242BBE";
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
    age.keyFile = "/home/juliuskoskela-unikie/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/secrets.yaml;
  };

  sops.secrets."users/juliuskoskela-unikie/ssh_key" = {
    path = "/home/juliuskoskela-unikie/.ssh/id_rsa";
  };

  sops.secrets."users/juliuskoskela-unikie/ssh_pubkey" = {
    path = "/home/juliuskoskela-unikie/.ssh/id_rsa.pub";
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
