
{
  description = "linux-porno";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # Official Hyprland plugins
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Dynamic Cursors
    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland";
    };
    # Hyprspace — workspace overview
    hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };


  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    ...
  } @ inputs:

  let
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

        modules = [
          ./modules/common.nix
          gpuModule
          ./hosts/${hostDir}/configuration.nix

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";

            home-manager.sharedModules = [
              inputs.nixvim.homeModules.nixvim
            ];

            home-manager.extraSpecialArgs = {
              inherit inputs;
            };

            home-manager.users.heshus = import ./home/home.nix;
          }
        ] ++ extraModules;
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
