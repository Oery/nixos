{ den, lib, ... }:
{
  den.aspects.audio = {
    nixos = { pkgs, ... }: {
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = pkgs.stdenv.hostPlatform.isx86_64;
        jack.enable = true;
        pulse.enable = true;
      };

      services.pulseaudio.enable = lib.mkForce false;
    };
  };
}
