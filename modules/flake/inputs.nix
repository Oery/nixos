# Inputs shared by the whole config. Inputs used by a single feature are
# declared next to it (grep for `flake-file.inputs`).
{
  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
