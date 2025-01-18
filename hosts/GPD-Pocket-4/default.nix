{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        extraConfig = ''
          terminal_output --append console
          terminal_output --remove gfxterm
          set rotation=270
          terminal_output gfxterm
        '';
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

  services = {
    illum.enable = true;
    kmscon.enable = true;
    greetd = {
      enable = true;
      settings.default_session.command = lib.getExe pkgs.wrappers.tuigreet;
      useTextGreeter = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
  };

  programs = {
    fish = {
      enable = true;
      package = pkgs.wrappers.fish.overrideAttrs (oldAttrs: {
        config = oldAttrs.config + ''
          if set -q KITTY_INSTALLATION_DIR
            set --global KITTY_SHELL_INTEGRATION enabled
            source "${pkgs.wrappers.kitty}/lib/kitty/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
            set --prepend fish_complete_path "${pkgs.wrappers.kitty}/lib/kitty/shell-integration/fish/vendor_completions.d"
          end
        '';
      });
    };
    niri = {
      enable = true;
      package = pkgs.wrappers.niri;
    };
    nh = {
      enable = true;
      flake = "/etc/nixos";
    };
    firefox = {
      enable = true;
      package = pkgs.firefox;
      languagePacks = [ "zh-CN" ];
    };
    steam.enable = true;
  };

  users = {
    defaultUserShell = config.programs.fish.package;
    users = {
      root.hashedPassword = "$y$j9T$vWgMPbsOGSZBigosFr2WM.$M.TVLph5zH55K50JMiQTdmCCTSdbOrSyYRLTsDKAz6A";
      Zh40Le1ZOOB = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        hashedPassword = "$y$j9T$vWgMPbsOGSZBigosFr2WM.$M.TVLph5zH55K50JMiQTdmCCTSdbOrSyYRLTsDKAz6A";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    fuzzel
    gh
    git
    gimp3
    inkscape
    localsend
    neovim
    neovide
    nixfmt-rfc-style
    wrappers.kitty
    vscode-fhs
    xwayland-satellite
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
