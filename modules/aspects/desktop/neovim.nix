{
  inputs,
  den,
  lib,
  ...
}:
{
  den.aspects.neovim = {
    nixos = { pkgs, ... }: {
      programs.neovim = {
        enable = true;
        # package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    };
  };
}
