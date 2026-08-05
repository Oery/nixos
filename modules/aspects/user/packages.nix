{ inputs, den, ... }:
{
  den.aspects.user.packages = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        nautilus

        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.helium-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

        pavucontrol
        obsidian
        vesktop
        equibop
        kitty

        awww
        quickshell
        chromium

        jq
        socat
        grimblast
        hyprpicker

        inputs.tree-sitter.packages.${pkgs.stdenv.hostPlatform.system}.default

        vscode
        code-cursor
        zed-editor
        opencode
        claude-code
        codex

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
      ];

      manual.html.enable = false;
      manual.json.enable = false;
      manual.manpages.enable = false;
    };
  };
}
