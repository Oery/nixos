{ den, lib, ... }:
{
  den.aspects.games.steam = {
    nixos = { pkgs, ... }: {
      programs.steam.enable = lib.mkIf pkgs.stdenv.hostPlatform.isx86_64 true;
    };
  };
}
