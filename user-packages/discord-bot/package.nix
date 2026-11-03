{
  lib,
  rustPlatform,
  source,
  revision,
}:
let
  src = lib.cleanSource source;
  manifest = builtins.fromTOML (builtins.readFile "${src}/Cargo.toml");
in
rustPlatform.buildRustPackage {
  pname = "bot-discord-chateau";
  version = "${manifest.package.version}-${builtins.substring 0 7 revision}";
  inherit src;

  # Read checksums from the bot's lockfile, so dependency updates need no
  # corresponding hash update in the system configuration.
  cargoLock.lockFile = "${src}/Cargo.lock";

  postInstall = ''
    mkdir -p "$out/share/bot-discord-chateau"
    printf '%s\n' ${lib.escapeShellArg revision} > "$out/share/bot-discord-chateau/revision"
  '';

  meta.mainProgram = "bot-discord-chateau";
}
