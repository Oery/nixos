# Home Manager half of the hyprland aspect (system half: ./system.nix).
# The Lua config is split across the `_*.nix` modules imported below.
{
  den.aspects.hyprland.provides.to-users = {
    homeManager = {
      imports = [
        ./_settings.nix
        ./_animations.nix
        ./_binds.nix
        ./_rules.nix
        ./_hyprlock.nix
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        configType = "lua";
      };

      home.file.".config/hypr/scripts/cycle-kbd-backlight.sh" = {
        source = ./scripts/cycle-kbd-backlight.sh;
        executable = true;
      };
      home.file.".config/hypr/scripts/apply-keyboard-color.sh" = {
        source = ./scripts/apply-keyboard-color.sh;
        executable = true;
      };
      home.file.".config/hypr/scripts/link-virtual-audio-cables.sh" = {
        source = ./scripts/link-virtual-audio-cables.sh;
        executable = true;
      };
      home.file.".config/hypr/scripts/hypr-workspace-monitor" = {
        source = ./scripts/hypr-workspace-monitor;
        executable = true;
      };
      home.file.".config/hypr/scripts/razer.py" = {
        source = ./scripts/razer.py;
        executable = true;
      };
      home.file.".config/hypr/hyprlock/status.sh" = {
        source = ./scripts/status.sh;
        executable = true;
      };
      home.file.".config/hypr/xdph.conf" = {
        text = ''
          screencopy {
            allow_token_by_default=true,
          }
        '';
      };
    };
  };
}
