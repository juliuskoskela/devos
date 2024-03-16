# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:pta2002/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    hyprwm-contrib.url = "github:hyprwm/contrib";
    hyprwm-contrib.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: let
    utils = import ./utils {inherit (inputs) home-manager sops-nix nixpkgs;};
    stateVersion = "24.05";
    sopsFile = ./secrets/secrets.yaml;
  in
    with inputs; {
      nixosConfigurations = {
        vega = let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          colors = nix-colors.colorSchemes.dracula;
          programs = import ./programs {inherit pkgs colors;};
          users = import ./users {inherit inputs utils pkgs programs stateVersion;};
          modules = [
            ./hosts/vega
            users."juliuskoskela"
            # users."juliuskoskela-unikie"
          ];
        in
          utils.mkSystem {inherit pkgs inputs system stateVersion sopsFile modules;};

        nova = let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          colors = nix-colors.colorSchemes.dracula;
          programs = import ./programs {inherit pkgs colors;};
          users = import ./users {inherit inputs utils pkgs programs stateVersion;};
          modules = [
            ./hosts/nova
            users."juliuskoskela"
            # users."juliuskoskela-unikie"
          ];
        in
          utils.mkSystem {inherit pkgs inputs system stateVersion sopsFile modules;};
      };
    }
    // (utils.setFormatter "alejandra" nixpkgs);
}
