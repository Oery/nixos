_: {
  den.aspects.neovim = {
    nixos = _: {
      programs.neovim = {
        enable = true;
        # package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    };
  };
}
