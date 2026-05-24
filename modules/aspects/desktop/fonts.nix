{ inputs, den, ... }:
{
  den.aspects.fonts = {
    nixos = { pkgs, ... }: {
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
