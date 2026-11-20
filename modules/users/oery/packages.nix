{ inputs, den, ... }:
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

  den.aspects.user.packages = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        nautilus

        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.helium-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

        pavucontrol
        obsidian
        vesktop

        awww
        quickshell

        jq
        socat
        grimblast
        hyprpicker

        mpv

        tree-sitter

        vscode
        zed-editor
        opencode
        codex
        claude-code
        omp

        rustc
        cargo
        clippy
        rust-analyzer
        rustfmt

        bun
        biome

        gcc
        gdb
        clang-tools
        vscode-langservers-extracted
        stylua

        kdePackages.qtdeclarative

        nil
        imagemagick
        playerctl

        # speedtest-cli
        speed-cloudflare-cli
        ookla-speedtest
      ];

      programs.herdr.enable = true;

      manual.html.enable = false;
      manual.json.enable = false;
      manual.manpages.enable = false;
    };
  };

}
