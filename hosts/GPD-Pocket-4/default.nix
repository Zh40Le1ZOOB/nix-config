{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };
    };
    initrd.verbose = false;
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelParams = [
      "amdgpu.dpm=0"
      "fbcon=rotate:1"
      "video=eDP-1:panel_orientation=right_side_up"
    ];
    plymouth.enable = true;
  };

  hardware = {
    amdgpu.initrd.enable = true;
    sensor.iio.enable = true;
  };

  networking = {
    hostName = "GPD-Pocket-4";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "en_US.UTF-8";

  console.earlySetup = true;

  fonts = {
    packages = with pkgs; [
      sarasa-gothic
      nerd-fonts.symbols-only
      twemoji-color-font
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "Sarasa Fixed SC"
          "Symbols Nerd Font Mono"
        ];
        sansSerif = [ "Sarasa Gothic SC" ];
        serif = [ "Sarasa Gothic SC" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };

  services = {
    illum.enable = true;
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    greetd = {
      enable = true;
      settings.default_session.command = "${pkgs.wrappers.tuigreet}/bin/tuigreet --cmd=niri";
    };
  };

  users.users.Zh40Le1ZOOB = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = config.programs.fish.package;
  };

  programs = {
    fish = {
      enable = true;
      package = pkgs.wrappers.fish;
    };
    nh = {
      enable = true;
      flake = "/etc/nixos";
    };
    niri = {
      enable = true;
      package = pkgs.wrappers.niri;
    };
  };

  environment.systemPackages = with pkgs; [
    fuzzel
    gh
    git
    inputs.zen-browser.packages.${system}.default
    wrappers.kitty
    neovim
    nixfmt-rfc-style
  ];

  documentation.man.generateCaches = lib.mkForce false;

  system.stateVersion = "25.05";

  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store" ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };
}
