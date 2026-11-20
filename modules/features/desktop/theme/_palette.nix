# Renoir terminal palette, shared by every terminal emulator config.
# Usage: import ../theme/_palette.nix
rec {
  background = "#080808";
  foreground = "#F7F1FF";
  cursor = "#F7F1FF";
  selection = {
    foreground = "#121517";
    background = "#F7F1FF";
  };

  # ANSI colours 0-15: normal (0-7) then bright (8-15).
  ansi = normal ++ bright;
  normal = [
    "#51576d" # black
    "#e78284" # red
    "#a6d189" # green
    "#e5c890" # yellow
    "#7E7D7E" # blue
    "#F7F1FF" # magenta
    "#F7F1FF" # cyan
    "#F7F1FF" # white
  ];
  bright = [
    "#626880"
    "#e67172"
    "#8ec772"
    "#d9ba73"
    "#7b9ef0"
    "#f2a4db"
    "#5abfb5"
    "#b5bfe2"
  ];
}
