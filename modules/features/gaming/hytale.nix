{ inputs, lib, ... }:
{
  flake-file.inputs.hytale-launcher = {
    url = "github:JPyke3/hytale-launcher-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.games.hytale = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
        inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.hytale-launcher
      ];
    };
  };
}
