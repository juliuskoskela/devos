# utils/default.nix
{
  home-manager,
  sops-nix,
  nixpkgs,
  ...
}: let
  mkUser = {
    username,
    description ? "User ${username}",
    extraGroups ? [],
    stateVersion,
    sessionVariables ? {},
    homeConfig ? {},
    imports ? [],
    packages ? [],
  }: let
    # passwordPath = "/var/lib/${username}/password";
  in {
    # sops.secrets."users/${username}/password" = {
    #   neededForUsers = true;
    #   path = passwordPath;
    # };

    users.users.${username} = {
      inherit description extraGroups;
      isNormalUser = true;
      # hashedPasswordFile = passwordPath;
    };

    home-manager.users.${username} =
      {
        inherit imports;

        home = {
          inherit username stateVersion sessionVariables packages;

          homeDirectory = "/home/${username}";
        };
      }
      // homeConfig;
  };

  mkSystem = {
    pkgs,
    inputs,
    system,
    stateVersion,
    sopsFile,
    modules ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      modules =
        [
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          {
            sops.defaultSopsFile = sopsFile;
          }
        ]
        ++ modules;

      specialArgs = {inherit pkgs inputs system stateVersion;};
    };

  mkGitUser = {
    username,
    email,
    gpgKey,
  }: {
    programs.git = {
      enable = true;
      lfs.enable = true;
      userName = username;
      userEmail = email;
      signing = {
        signByDefault = true;
        key = gpgKey;
      };
    };
  };

  defaultSystems = [
    "aarch64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
    "x86_64-linux"
  ];

  eachSystem = systems: f: let
    # Merge together the outputs for all systems.
    op = attrs: system: let
      ret = f system;
      op = attrs: key:
        attrs
        // {
          ${key} =
            (attrs.${key} or {})
            // {${system} = ret.${key};};
        };
    in
      builtins.foldl' op attrs (builtins.attrNames ret);
  in
    builtins.foldl' op {}
    (systems
      ++ # add the current system if --impure is used
      (
        if builtins ? currentSystem
        then
          if builtins.elem builtins.currentSystem systems
          then []
          else [builtins.currentSystem]
        else []
      ));

  eachDefaultSystem = eachSystem defaultSystems;

  setFormatter = name:
    eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      formatter = pkgs.${name};
    });
in {
  inherit mkUser mkSystem mkGitUser eachDefaultSystem setFormatter;
}
