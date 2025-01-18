{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wrapper-manager = {
      url = "github:viperML/wrapper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      wrapper-manager,
      nix-on-droid,
      ...
    }@inputs:
    let
      myOverlays = import ./overlays {
        inherit (nixpkgs) lib;
        inherit wrapper-manager;
      };
    in
    {
      nixosConfigurations.GPD-Pocket-4 = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          inherit system inputs;
        };
        modules = [
          { nixpkgs.overlays = [ myOverlays ]; }
          ./hosts/GPD-Pocket-4
        ];
      };
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          overlays = [ myOverlays ];
        };
        modules = [ ./hosts/phone ];
      };
    };
}
