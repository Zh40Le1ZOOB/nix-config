{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
      wrapper-manager,
      catppuccin,
      nix-on-droid,
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
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          overlays = [ overlays ];
        };
        modules = [ ./hosts/phone ];
      };
    };
}
