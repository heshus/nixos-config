{
  description = "linux-porno";
  inputs = {
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    nixvim.url = "github:nix-community/nixvim";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    grub2-themes,
    ...
  } @ inputs: let
    mkHost = {
      hostDir,
      gpuModule,
      extraModules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules =
          [
            ./modules/common.nix
            gpuModule
            ./hosts/${hostDir}/configuration.nix
            grub2-themes.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                inputs.nixvim.homeModules.nixvim
              ];
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
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
