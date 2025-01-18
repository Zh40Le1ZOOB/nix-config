{ pkgs, ... }:
{
  wrappers.niri = {
    basePackage = pkgs.niri;
    env.NIRI_CONFIG.value = pkgs.writeTextFile {
      name = "niri.kdl";
      text = ''
        output "eDP-1" {
          scale 2
          transform "270"
        }
        binds {
          Mod+Shift+Slash { show-hotkey-overlay; }

          Mod+T { spawn "kitty"; }
          Mod+B { spawn "firefox-devedition"; }
          Mod+D { spawn "fuzzel"; }
          Super+Alt+L { spawn "swaylock"; }

          XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+"; }
          XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-"; }
          XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
          XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

          Mod+Q { close-window; }

          Mod+Left  { focus-column-left; }
          Mod+Right { focus-column-right; }
          Mod+Up    { focus-window-or-workspace-up; }
          Mod+Down  { focus-window-or-workspace-down; }

          Mod+Home { focus-column-first; }
          Mod+End  { focus-column-last; }

          Mod+WheelScrollLeft  { focus-column-left; }
          Mod+WheelScrollRight { focus-column-right; }
          Mod+WheelScrollUp    { focus-workspace-up; }
          Mod+WheelScrollDown  { focus-workspace-down; }

          Mod+Shift+Left  { focus-monitor-left; }
          Mod+Shift+Right { focus-monitor-right; }
          Mod+Shift+Up    { focus-monitor-up; }
          Mod+Shift+Down  { focus-monitor-down; }

          Mod+Ctrl+Left     { move-column-left; }
          Mod+Ctrl+Right    { move-column-right; }
          Mod+Ctrl+Up       { move-window-up-or-to-workspace-up; }
          Mod+Ctrl+Down     { move-window-down-or-to-workspace-down; }
          Mod+Ctrl+Alt+Up   { move-column-to-workspace-up; }
          Mod+Ctrl+Alt+Down { move-column-to-workspace-down; }

          Mod+Ctrl+Home { move-column-to-first; }
          Mod+Ctrl+End  { move-column-to-last; }

          Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
          Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
          Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
          Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }

          Mod+Shift+Alt+Up   { move-workspace-up; }
          Mod+Shift+Alt+Down { move-workspace-down; }

          Mod+0 { focus-workspace 1; }
          Mod+1 { focus-workspace 2; }
          Mod+2 { focus-workspace 3; }
          Mod+3 { focus-workspace 4; }
          Mod+4 { focus-workspace 5; }
          Mod+5 { focus-workspace 6; }
          Mod+6 { focus-workspace 7; }
          Mod+7 { focus-workspace 8; }
          Mod+8 { focus-workspace 9; }
          Mod+9 { focus-workspace 10; }
          Mod+Ctrl+0 { move-column-to-workspace 1; }
          Mod+Ctrl+1 { move-column-to-workspace 2; }
          Mod+Ctrl+2 { move-column-to-workspace 3; }
          Mod+Ctrl+3 { move-column-to-workspace 4; }
          Mod+Ctrl+4 { move-column-to-workspace 5; }
          Mod+Ctrl+5 { move-column-to-workspace 6; }
          Mod+Ctrl+6 { move-column-to-workspace 7; }
          Mod+Ctrl+7 { move-column-to-workspace 8; }
          Mod+Ctrl+8 { move-column-to-workspace 9; }
          Mod+Ctrl+9 { move-column-to-workspace 10; }

          Mod+Tab { focus-workspace-previous; }

          Mod+BracketLeft  { consume-or-expel-window-left; }
          Mod+BracketRight { consume-or-expel-window-right; }

          Mod+Comma  { consume-window-into-column; }
          Mod+Period { expel-window-from-column; }

          Mod+R { switch-preset-column-width; }
          Mod+Shift+R { switch-preset-window-height; }
          Mod+Ctrl+R { reset-window-height; }
          Mod+F { maximize-column; }
          Mod+Shift+F { fullscreen-window; }
          Mod+C { center-column; }

          Mod+Minus { set-column-width "-10%"; }
          Mod+Equal { set-column-width "+10%"; }

          Mod+Shift+Minus { set-window-height "-10%"; }
          Mod+Shift+Equal { set-window-height "+10%"; }

          Mod+V       { toggle-window-floating; }
          Mod+Shift+V { switch-focus-between-floating-and-tiling; }

          Print { screenshot; }
          Ctrl+Print { screenshot-screen; }
          Alt+Print { screenshot-window; }

          Mod+Shift+E { quit; }
          Ctrl+Alt+Delete { quit; }

          Mod+Shift+P { power-off-monitors; }
        }
        layout {
          center-focused-column "on-overflow"
          always-center-single-column
          empty-workspace-above-first
          focus-ring {
            active-gradient from="#5bcefa" to="#f5a9b8" angle=135 in="oklch longer hue"
          }
          insert-hint {
            gradient from="#5bcefa" to="#f5a9b8" angle=135 in="oklch longer hue"
          }
        }
        spawn-at-startup "${pkgs.iio-niri}/bin/iio-niri"
        spawn-at-startup "${pkgs.wrappers.kitty-wallpaper}/bin/kitty"
        prefer-no-csd
        cursor {
          hide-when-typing
          hide-after-inactive-ms 2000
        }
        hotkey-overlay {
          skip-at-startup
        }
        window-rule {
          geometry-corner-radius 10
          clip-to-geometry true
        }
        animations {
          workspace-switch {
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
          }
          window-open {
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
          }
          window-close {
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
          }
          horizontal-view-movement {
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
          }
          window-movement {
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
          }
          window-resize {
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
          }
          config-notification-open-close {
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
          }
          screenshot-ui-open {
            spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
          }
        }
      '';
      checkPhase = "${pkgs.niri}/bin/niri validate --config=$out";
    };
  };
}
