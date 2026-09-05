{
  description = "linux-porno";
  inputs = {
    nixvim.url = "github:nix-community/nixvim";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    zen-browser,
    nixvim,
    ...
  } @ inputs: let
    secrets = import /home/heshus/.config/nixos-secrets/secrets.nix;
    mkHost = {
      hostDir,
      gpuModule,
      extraModules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs zen-browser secrets;
        };
        modules =
          [
            ./modules/common.nix
            gpuModule
            ./hosts/${hostDir}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs secrets;
              };
              home-manager.sharedModules = [
                inputs.nixvim.homeModules.nixvim
              ];
              home-manager.users.heshus = import ./home/home.nix;
            }
          ]
          ++ extraModules;
      };
  in {
    nixosConfigurations = {
      nixos-laptop = mkHost {
        hostDir = "laptop";
        gpuModule = ./modules/gpu-amd.nix;
      };
      nixos-desktop = mkHost {
        hostDir = "desktop";
        gpuModule = ./modules/gpu-nvidia.nix;
        extraModules = [
          ./modules/symlinks.nix
        ];
      };
    };
  };
}
