#!/usr/bin/env bash
# One-time migration: encrypt the hand-placed secrets on Fate into ./*.age and
# create a restic repository password.
#
# Run it on Fate as your user (it uses sudo to read root-owned files), in your
# own terminal so the restic password it prints stays out of any logs:
#   cd /etc/nixos/secrets && ./import.sh
#
# Existing .age files are skipped, so it is safe to re-run.
set -euo pipefail
cd "$(dirname "$0")"

# The substituter override skips the dead Fate cache still listed in nix.conf on
# systems built before the refactor; it is harmless afterwards.
agenix() {
  nix run --option substituters "https://cache.nixos.org" --inputs-from .. agenix -- "$@"
}

check_written() {
  if [[ ! -s "$1" ]]; then
    echo "error: $1 was not created" >&2
    exit 1
  fi
}

# agenix -e reads the cleartext from stdin when it is piped in.
encrypt() {
  local name=$1 src=$2
  if [[ -e "$name.age" ]]; then
    echo "skip   $name.age (already exists)"
    return
  fi
  sudo test -s "$src" || {
    echo "error: $src is missing or empty" >&2
    exit 1
  }
  sudo cat "$src" | agenix -e "$name.age"
  check_written "$name.age"
  echo "wrote  $name.age  (from $src)"
}

encrypt wg-conf /data/.secret/vpn/wg.conf
encrypt discord-bot-env /var/lib/discord-bot/environment
encrypt discord-bot-deploy-key /var/lib/discord-bot-deploy-key

if [[ ! -e restic-password.age ]]; then
  password=$(head -c 32 /dev/urandom | base64)
  printf '%s' "$password" | agenix -e restic-password.age
  check_written restic-password.age
  echo "wrote  restic-password.age"
  echo
  echo "Restic password (save it in your password manager next to the recovery key):"
  echo "  $password"
fi
