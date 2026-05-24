{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.vscode-server.nixosModules.default ];

  wsl = {
    enable = true;
    defaultUser = "Zh40Le1ZOOB";
  };

  networking.hostName = "WSL";

  services.vscode-server.enable = true;

  programs = {
    fish = {
      enable = true;
      package = pkgs.wrappers.fish;
    };
    nh = {
      enable = true;
      flake = "/etc/nixos";
    };
  };

  users.defaultUserShell = config.programs.fish.package;

  environment.systemPackages = with pkgs; [
    gh
    git
    neovim
    nixfmt
  ];

  documentation.man.generateCaches = lib.mkForce false;

  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  system.stateVersion = "26.11";
}
