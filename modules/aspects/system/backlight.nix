{ den, ... }:
{
  den.aspects.backlight = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        brightnessctl
        alsa-utils
      ];

      services.acpid = {
        enable = true;

        handlers = {
          brightness-up = {
            event = "video/brightnessup";
            action = "${pkgs.brightnessctl}/bin/brightnessctl set 10%+";
          };

          brightness-down = {
            event = "video/brightnessdown";
            action = "${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
          };
        };
      };
    };
  };
}
