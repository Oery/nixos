# agenix recipients: who can decrypt each secret. Any ONE of these keys is
# enough to decrypt, so losing one of them is recoverable.
#
# Edit a secret (from this directory):   agenix -e wg-conf.age
# After changing the keys below:         agenix -r   (re-encrypt everything)
let
  # Personal key, for editing secrets from a workstation.
  oery = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIArDjHFe6c6gYmhpwpVcaxr2kw/3OWy3kfpJcmmauLCK";
  # Recovery key; its private half lives only in the password manager.
  recovery = "age180kf8h8qhmuhj8z4cmca3r5av728kfx6xlyvuaplaf78u8exuq5sljg7qp";
  # Fate's SSH host key (/etc/ssh/ssh_host_ed25519_key): decrypts at boot.
  fate = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBwbh3dirsU9h4ajth5WU273q+8jR6EMyyTysUYXFocz";

  fateSecret = [
    oery
    recovery
    fate
  ];
in
{
  "wg-conf.age".publicKeys = fateSecret;
  "discord-bot-env.age".publicKeys = fateSecret;
  "discord-bot-deploy-key.age".publicKeys = fateSecret;
  "restic-password.age".publicKeys = fateSecret;
}
