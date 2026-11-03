{
  lib,
  makeRustPlatform,
  rust-bin,
  makeWrapper,
  git,
  src,
}:
let
  toolchain = rust-bin.fromRustupToolchainFile "${src}/rust-toolchain.toml";
  rustPlatform = makeRustPlatform {
    cargo = toolchain;
    rustc = toolchain;
  };
in
rustPlatform.buildRustPackage {
  pname = "personal-mcp-servers";
  version = "0.1.0-${builtins.substring 0 7 src.rev}";
  inherit src;

  cargoLock.lockFile = "${src}/Cargo.lock";
  cargoBuildFlags = [
    "-p"
    "mcp-nightbot"
    "-p"
    "mcp-obsidian"
  ];
  cargoTestFlags = [ "--workspace" ];

  nativeBuildInputs = [ makeWrapper ];
  nativeCheckInputs = [ git ];

  postInstall = ''
    wrapProgram "$out/bin/mcp-obsidian" --prefix PATH : ${lib.makeBinPath [ git ]}
  '';

  meta = {
    description = "Personal MCP servers for Nightbot and Obsidian";
    homepage = "https://github.com/Oery/my-mcp-servers";
    platforms = lib.platforms.unix;
  };
}
