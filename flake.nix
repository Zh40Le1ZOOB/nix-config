{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    wrapper-manager.url = "github:Zh40Le1ZOOB/wrapper-manager";
    catppuccin.url = "github:catppuccin/nix";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      nix-on-droid,
      wrapper-manager,
      catppuccin,
      ...
    }@inputs:
    let
      overlays = import ./overlays {
        inherit (nixpkgs) lib;
        inherit wrapper-manager catppuccin;
      };
    in
    {
      nixosModules.default.imports = nixpkgs.lib.filesystem.listFilesRecursive ./modules/nixos;

      nixosConfigurations.GPD-Pocket-4 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          self.nixosModules.default

          {
            nixpkgs = {
              config.allowUnfree = true;
              config.allowBroken = true;
              overlays = [ overlays ];
            };
          }

          ./hosts/GPD-Pocket-4
        ];
      };

      nixosConfigurations.WSL = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          { wsl.enable = true; }

          {
            nixpkgs = {
              config.allowUnfree = true;
              config.allowBroken = true;
              overlays = [ overlays ];
            };
          }

          ./hosts/WSL
        ];
      };

      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          overlays = [ overlays ];
        };
        modules = [ ./hosts/Droid ];
      };
    };
}
