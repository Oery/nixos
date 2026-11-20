# Helpers for the Hyprland Lua config. Usage: import ./_lib.nix lib
lib: rec {
  lua = lib.generators.mkLuaInline;
  bind = keys: action: {
    _args = [
      keys
      (lua action)
    ];
  };
  bindWith = flags: keys: action: {
    _args = [
      keys
      (lua action)
      flags
    ];
  };
  exec = keys: command: bind keys "hl.dsp.exec_cmd(${builtins.toJSON command})";
  execWith =
    flags: keys: command:
    bindWith flags keys "hl.dsp.exec_cmd(${builtins.toJSON command})";
  env = name: value: {
    _args = [
      name
      value
    ];
  };
  curve = name: points: {
    _args = [
      name
      {
        type = "bezier";
        inherit points;
      }
    ];
  };
}
