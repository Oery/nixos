{ inputs, lib, den, ... }:
let
  flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
  nixRegistry = lib.mapAttrs (_: v: { flake = v; }) flakeInputs;
in
{
  den.aspects.nix = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.git ];

      environment.variables.NH_OS_FLAKE = "/etc/nixos";

      nix = {
        package = pkgs.lix;

        registry = nixRegistry;

        nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") nixRegistry;

        settings = {
          auto-optimise-store = true;
          builders-use-substitutes = true;
          experimental-features = [ "nix-command" "flakes" ];
          flake-registry = "/etc/nix/registry.json";

          keep-derivations = true;
          keep-outputs = true;

          trusted-users = [ "root" "@wheel" ];

          accept-flake-config = false;

          substituters = [
            "https://cache.nixos.org?priority=10"
            "https://helix.cachix.org"
            "https://hyprland.cachix.org"
            "https://nix-community.cachix.org"
            "https://nix-gaming.cachix.org"
          ];

          trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          ];
        };
      };

      programs.nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep-since 30d";
        };
      };

      nixpkgs.config.allowUnfree = true;
    };
  };
}
