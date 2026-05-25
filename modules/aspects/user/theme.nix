{
  inputs,
  ...
}:
{
  den.aspects.user.theme = {
    homeManager =
      { pkgs, config, ... }:
      {
        home.pointerCursor = {
          gtk.enable = true;
          x11.enable = true;
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 16;
        };

        dconf.settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
          };
        };

        gtk = {
          enable = true;

          font = {
            name = "Iosevka Medium";
            package = pkgs.iosevka;
            size = 10;
          };

          # iconTheme = {
          #   name = "yet-another-monochrome-icon-set";
          #   package = inputs.yamis.packages.${pkgs.stdenv.hostPlatform.system};
          # };

          theme = {
            name = "Ugly-Red-Cyan";
            package = pkgs.callPackage ../../../user-packages/ugly-red-cyan-theme.nix { };
          };

          gtk4.theme = {
            name = "Ugly-Red-Cyan";
            package = pkgs.callPackage ../../../user-packages/ugly-red-cyan-theme.nix { };
          };
        };
      };
  };
}
