# NixOS configuration

Dendritic flake built with [den](https://github.com/denful/den): every file
under `modules/` is a flake-parts module, imported automatically by
import-tree. `flake.nix` is generated; run `nix run .#write-flake` after
adding or changing a `flake-file.inputs` entry.

## Layout

```
modules/
  flake/      wiring: hosts list, den defaults, shared inputs, nh, dotfiles, lint
  roles/      base, workstation, laptop, homelab: includes only, no config
  hosts/      one directory per machine: includes + hardware + real quirks
  features/   one aspect per concern
    system/     core, nix, network, bluetooth, power, ...
    desktop/    hyprland, theme, terminals, session, apps, audio, fonts
    apps/ gaming/ homelab/
  users/oery/ identity + what follows the user everywhere (shell, git, CLI, dev)
```

| Host       | Roles                         |
|------------|-------------------------------|
| Stronghold | base, workstation             |
| Fate       | base, workstation, homelab    |
| L16        | base, workstation, laptop     |
| ZenBook    | base, workstation, laptop     |
| Elysium    | base, workstation, laptop     |

## Conventions

- **A feature owns every class it touches.** System config goes in the
  aspect's `nixos`; its Home Manager half goes in the same aspect under
  `provides.to-users.homeManager`. Never put `homeManager` directly on a
  host or an aspect a host includes: den drops it silently.
- **Hosts** contain only `includes`, hardware, and settings that are truly
  specific to that machine (monitors, bootloader, GPU). No shared package
  lists.
- **Roles** contain only `includes`.
- **Users** contain identity and what should follow the user to *every*
  machine. Anything desktop-only belongs in a desktop feature.
- **Aspect names** are kebab-case; nested namespaces only for families
  (`games.*`, `roles.*`).
- **Flake inputs** are declared with `flake-file.inputs` in the file that
  uses them; only nixpkgs and home-manager live in `flake/inputs.nix`.
- **Non-module files** (packages for `callPackage`, plain HM modules,
  helpers) go in `_`-prefixed files or directories next to their feature;
  import-tree skips any path containing `/_`. No `../` paths across features.

## Commands

```
nh os switch                          # build + switch this host
nix fmt                               # format
nix build .#checks.x86_64-linux.lint  # nixfmt --check, deadnix, statix
nix build .#dotfiles                  # Stronghold's dotfiles as plain files
                                      # (result/home, result/store-references.txt)
```
