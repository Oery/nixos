{ inputs, den, ... }:
{
  den.aspects.fonts = {
    nixos = { pkgs, ... }: {
      # Iosevka uses nodejs_latest (26), whose V8 fails to compile on aarch64
      # because memcopy.h uses CHAR_BIT without including <climits>.
      nixpkgs.overlays = [
        (final: prev: {
          iosevka = prev.iosevka.override {
            nodejs_latest = final.nodejs_24;
          };
        })
      ];

      fonts = {
        packages = with pkgs; [
          material-symbols

          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-color-emoji

          iosevka
          jetbrains-mono

          nerd-fonts.iosevka
          nerd-fonts.jetbrains-mono
          nerd-fonts.symbols-only

          fairfax

          inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro
        ];

        enableDefaultPackages = false;
      };
    };
  };
}
