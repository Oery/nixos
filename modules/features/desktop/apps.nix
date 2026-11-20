# Graphical apps for every workstation user.
{ inputs, ... }:
{
  flake-file.inputs = {
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    helium-browser = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.desktop-apps.provides.to-users = {
    homeManager =
      { pkgs, ... }:
      let
        system = pkgs.stdenv.hostPlatform.system;
      in
      {
        programs.mpv = {
          enable = true;
          config.hwdec = "auto";
        };

        home.packages = with pkgs; [
          inputs.zen-browser.packages.${system}.default
          inputs.helium-browser.packages.${system}.default

          nautilus
          pavucontrol
          obsidian
          vesktop
          vscode
          zed-editor

          # Hyprland / quickshell desktop helpers
          awww
          quickshell
          kdePackages.qtdeclarative
          grimblast
          hyprpicker
          playerctl
        ];
      };
  };
}
