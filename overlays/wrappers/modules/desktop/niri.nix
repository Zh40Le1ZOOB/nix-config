{
  config,
  lib,
  pkgs,
  ...
}:
{
  wrappers.niri = {
    basePackage = pkgs.niri;
    env.NIRI_CONFIG.value = pkgs.writeTextFile {
      name = "niri.kdl";
      checkPhase = "${lib.getExe pkgs.niri} validate --config=$out";
      text = ''
        input {
          focus-follows-mouse
        }

        output "eDP-1" {
          scale 2
          transform "270"
        }

        binds {
          // Mod+Slash { show-hotkey-overlay; }

          Ctrl+Alt+Delete { quit; }

          Mod+T { spawn "kitty";    }
          Mod+B { spawn "firefox";  }
          Mod+D { spawn "fuzzel";   }
          Mod+L { spawn "swaylock"; }

          XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+";  }
          XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-";  }
          XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";   }
          XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

          Print      { screenshot;        }
          Alt+Print  { screenshot-window; }
          Ctrl+Print { screenshot-screen; }

          Mod+Escape { toggle-keyboard-shortcuts-inhibit; }

          Mod+Q { close-window; }

          Mod+Ctrl+F { fullscreen-window; }

          Mod+Home      { focus-column-first;             }
          Mod+End       { focus-column-last;              }
          Mod+Left      { focus-column-left-or-last;      }
          Mod+Right     { focus-column-right-or-first;    }
          Mod+Up        { focus-window-or-workspace-up;   }
          Mod+Down      { focus-window-or-workspace-down; }
          Mod+Page_Up   { focus-workspace-up;             }
          Mod+Page_Down { focus-workspace-down;           }

          Mod+Alt+Home      { move-column-to-first;                  }
          Mod+Alt+End       { move-column-to-last;                   }
          Mod+Alt+Left      { move-column-left;                      }
          Mod+Alt+Right     { move-column-right;                     }
          Mod+Alt+Up        { move-window-up-or-to-workspace-up;     }
          Mod+Alt+Down      { move-window-down-or-to-workspace-down; }
          Mod+Alt+Page_Up   { move-column-to-workspace-up;           }
          Mod+Alt+Page_Down { move-column-to-workspace-down;         }

          Mod+Comma      { consume-or-expel-window-left;  }
          Mod+Period     { consume-or-expel-window-right; }
          Mod+Alt+Comma  { swap-window-left;              }
          Mod+Alt+Period { swap-window-right;             }

          Mod+Alt+Tab { toggle-column-tabbed-display; }

          Mod+C     { center-column;          }
          Mod+Alt+C { center-visible-columns; }

          Mod+F     { maximize-column;   }
          Mod+Alt+F { expand-column-to-available-width; }

          Mod+Minus     { set-column-width "-10%";  }
          Mod+Equal     { set-column-width "+10%";  }
          Mod+Alt+Minus { set-window-height "-10%"; }
          Mod+Alt+Equal { set-window-height "+10%"; }
          Mod+Alt+R     { reset-window-height;      }

          Mod+Ctrl+Up   { move-workspace-up;   }
          Mod+Ctrl+Down { move-workspace-down; }

          Mod+V     { switch-focus-between-floating-and-tiling; }
          Mod+Alt+V { toggle-window-floating;                   }

          Mod+Tab     { toggle-overview; }
        }

        layout {
          center-focused-column "on-overflow"
          always-center-single-column
          empty-workspace-above-first
          focus-ring {
            active-gradient from="#5bcefa" to="#f5a9b8" angle=135 in="oklch longer hue"
          }
          shadow {
            on
          }
          tab-indicator {
            hide-when-single-tab
            place-within-column
            gaps-between-tabs 1
            corner-radius 10
          }
          insert-hint {
            gradient from="#5bcefa" to="#f5a9b8" angle=135 in="oklch longer hue"
          }
        }

        spawn-at-startup "${lib.getExe pkgs.iio-niri}"
        spawn-at-startup "${lib.getExe config.build.packages.kitty-wallpaper}"
        spawn-at-startup "fcitx5"

        prefer-no-csd

        environment {
          ELECTRON_OZONE_PLATFORM_HINT "auto"
        }

        cursor {
          hide-when-typing
          hide-after-inactive-ms 1000
        }

        hotkey-overlay {
          skip-at-startup
          hide-not-bound
        }

        window-rule {
          geometry-corner-radius 10
          clip-to-geometry true
        }
      '';
    };
  };
}
