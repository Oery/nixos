# CLI and development tools, wanted on every machine. GUI apps live in
# features/desktop/apps.nix.
{ den, ... }:
{
  den.aspects.user.packages = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        jq
        socat
        imagemagick

        tree-sitter

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

        nil

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
