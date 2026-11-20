# `nix build .#dotfiles` — Stronghold's Home Manager files as a plain tree,
# for copying onto machines without Nix:
#   result/home/                   the files, symlinks resolved (mirror of ~)
#   result/store-references.txt    files still pointing at /nix/store paths;
#                                  these need manual fixing on a non-Nix host
{ self, lib, ... }:
let
  host = self.nixosConfigurations.Stronghold;
in
{
  perSystem =
    { pkgs, system, ... }:
    {
      packages = lib.mkIf (system == "x86_64-linux") {
        dotfiles = pkgs.runCommandLocal "dotfiles-stronghold" { } ''
          mkdir -p $out
          cp -rL ${host.config.home-manager.users.oery.home-files} $out/home
          chmod -R u+w $out/home
          (cd $out/home && grep -rlI /nix/store . || true) | sed 's|^\./||' | sort > $out/store-references.txt
        '';
      };
    };
}
