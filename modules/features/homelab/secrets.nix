# Homelab secrets, encrypted with agenix. The .age files and the list of keys
# that can decrypt them live in /etc/nixos/secrets (see agenix-rules.nix there).
# On activation they are decrypted with Fate's SSH host key to
# /run/agenix/<name>; services use config.age.secrets.<name>.path.
{ inputs, ... }:
{
  flake-file.inputs.agenix = {
    url = "github:ryantm/agenix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.homelab-secrets.nixos =
    { pkgs, ... }:
    {
      imports = [ inputs.agenix.nixosModules.default ];
      environment.systemPackages = [
        inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      # Owned by root, mode 0400: every consumer reads them as root
      # (wg-quick, systemd EnvironmentFile/LoadCredential, restic).
      age.secrets = {
        wg-conf.file = ../../../secrets/wg-conf.age;
        discord-bot-env.file = ../../../secrets/discord-bot-env.age;
        discord-bot-deploy-key.file = ../../../secrets/discord-bot-deploy-key.age;
        restic-password.file = ../../../secrets/restic-password.age;
      };
    };
}
