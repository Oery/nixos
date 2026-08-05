{ den, lib, ... }:
{
  den.aspects.games.emulation = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = lib.optionals pkgs.stdenv.hostPlatform.isx86_64 (with pkgs; [
        azahar        # 3DS emulator (was AUR azahar)
        xenia-canary  # Xbox 360 emulator (was AUR xenia-edge-bin; canary fork)
      ]);
    };
  };
}
