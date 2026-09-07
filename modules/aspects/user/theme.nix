{
  inputs,
  ...
}:
{
  den.aspects.user.theme = {
    homeManager =
      { pkgs, config, ... }:
      let
        renoirTheme = pkgs.callPackage ../../../user-packages/renoir-gtk-theme.nix { };
      in
      {
        home.pointerCursor = {
          enable = true;
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

          iconTheme = {
            name = "yet-another-monochrome-icon-set";
            package = pkgs.callPackage ../../../user-packages/yamis/package.nix { };
          };

          theme = {
            name = "Renoir";
            package = renoirTheme;
          };

          gtk4 = {
            theme = null;
            extraConfig.gtk-application-prefer-dark-theme = true;
            extraCss = ''
              @import url("file://${renoirTheme}/share/themes/Renoir/gtk-4.0/gtk.css");
            '';
          };
        };
      };
  };
}
