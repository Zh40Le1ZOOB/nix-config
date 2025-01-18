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
    amdgpu = {
      initrd.enable = true;
      amdvlk.enable = true;
    };
    sensor.iio.enable = true;
  };

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "GPD-Pocket-4";
    networkmanager.enable = true;
  };

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

  virtualisation.waydroid.enable = true;

  services = {
    illum.enable = true;
    greetd = {
      enable = true;
      settings.default_session.command = "${pkgs.wrappers.tuigreet}/bin/tuigreet --cmd='niri --session'";
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
    firefox-devedition
    gh
    git
    gimp3
    inkscape
    localsend
    neovim
    nixfmt-rfc-style
    unzip
    wrappers.kitty
    waydroid-helper
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
