{ inputs, den, lib, ... }:
{
  den.aspects.games.hytale = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
        inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.hytale-launcher
      ];
    };
  };
}
