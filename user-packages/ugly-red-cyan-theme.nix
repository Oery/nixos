{ pkgs, lib }:

pkgs.stdenv.mkDerivation {
  pname = "ugly-red-cyan-theme";
  version = "1.0";

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/share/themes/Ugly-Red-Cyan/gtk-3.0
    mkdir -p $out/share/themes/Ugly-Red-Cyan/gtk-4.0

    cat > $out/share/themes/Ugly-Red-Cyan/index.theme << 'EOF'
[Desktop Entry]
Type=X-GNOME-Metatheme
Name=Ugly-Red-Cyan
Comment=Dark GTK theme matching ghostty renoir colors

[GTK 3.0]
Name=Ugly-Red-Cyan
Comment=Dark GTK3 theme matching ghostty renoir

[GTK 4.0]
Name=Ugly-Red-Cyan
Comment=Dark GTK4 theme matching ghostty renoir
EOF

    cat > $out/share/themes/Ugly-Red-Cyan/gtk-3.0/gtk.css << 'CSS'
@define-color theme_bg_color #080808;
@define-color theme_fg_color #F7F1FF;
@define-color theme_base_color #080808;
@define-color theme_text_color #F7F1FF;
@define-color theme_selected_bg_color rgba(123, 158, 240, 0.35);
@define-color theme_selected_fg_color #F7F1FF;
@define-color theme_unfocused_bg_color #080808;
@define-color theme_unfocused_fg_color #b5bfe2;
@define-color theme_unfocused_base_color #080808;
@define-color theme_unfocused_text_color #b5bfe2;
@define-color theme_unfocused_selected_bg_color rgba(123, 158, 240, 0.2);
@define-color theme_unfocused_selected_fg_color #b5bfe2;
@define-color borders #3a3f4d;
@define-color unfocused_borders #2d323e;
@define-color warning_color #e5c890;
@define-color error_color #e78284;
@define-color success_color #5abfb5;

* {
  background-color: @theme_bg_color;
  color: @theme_fg_color;
  border-color: @borders;
}

button {
  background-color: #080808;
  color: #F7F1FF;
  border: 1px solid #3a3f4d;
}

button:hover {
  background-color: #1a1e24;
}

button:active {
  background-color: #121517;
}

button:checked {
  background-color: rgba(123, 158, 240, 0.3);
  color: #F7F1FF;
}

entry {
  background-color: @theme_base_color;
  color: @theme_text_color;
  border: 1px solid #3a3f4d;
}

entry:focus {
  border-color: #7b9ef0;
}

label {
  color: #F7F1FF;
}

textview text {
  background-color: @theme_base_color;
  color: @theme_text_color;
}

textview {
  background-color: @theme_bg_color;
}

.view {
  background-color: @theme_base_color;
  color: @theme_text_color;
}

.view:selected,
textview text:selected,
entry text:selected,
label:selected {
  background-color: rgba(123, 158, 240, 0.35);
  color: #F7F1FF;
}

rubberband {
  background-color: rgba(247, 241, 255, 0.15);
  border: 1px solid #F7F1FF;
}

scrollbar {
  background-color: transparent;
}

scrollbar slider {
  background-color: #3a3f4d;
  border-radius: 4px;
  min-width: 6px;
  min-height: 6px;
}

scrollbar slider:hover {
  background-color: #51576d;
}

scrollbar slider:active {
  background-color: #626880;
}

.titlebar {
  background-color: #080808;
  color: #F7F1FF;
}

toolbar,
.sidebar {
  background-color: #080808;
  color: #F7F1FF;
  border-right: 1px solid #3a3f4d;
}

toolbar:backdrop,
.sidebar:backdrop {
  background-color: #080808;
  color: #b5bfe2;
}

.sidebar scrolledwindow,
.sidebar viewport,
.sidebar row {
  background-color: #080808;
}

.sidebar scrolledwindow:backdrop,
.sidebar viewport:backdrop,
.sidebar row:backdrop {
  background-color: #080808;
}

.sidebar row:hover {
  background-color: #1a1e24;
}

.sidebar row:selected {
  background-color: #1a1e24;
  color: #F7F1FF;
}

.sidebar row:selected:backdrop {
  background-color: #1a1e24;
  color: #b5bfe2;
}

menu {
  background-color: #121517;
  color: #F7F1FF;
  border: 1px solid #3a3f4d;
}

menuitem {
  background-color: transparent;
  color: #F7F1FF;
}

menuitem:hover {
  background-color: rgba(123, 158, 240, 0.3);
  color: #F7F1FF;
}

headerbar {
  background-color: #080808;
  color: #F7F1FF;
  border-bottom: 1px solid #3a3f4d;
}

notebook {
  background-color: #080808;
}

notebook tab {
  background-color: #121517;
  color: #b5bfe2;
  border: 1px solid #3a3f4d;
}

notebook tab:checked {
  background-color: #080808;
  color: #F7F1FF;
  border-bottom-color: #080808;
}

checkbutton check {
  background-color: #1a1e24;
  border: 1px solid #3a3f4d;
}

checkbutton check:checked {
  background-color: #7b9ef0;
  border-color: #7b9ef0;
}

radiobutton radio {
  background-color: #1a1e24;
  border: 1px solid #3a3f4d;
}

radiobutton radio:checked {
  background-color: #7b9ef0;
  border-color: #7b9ef0;
}

scale trough {
  background-color: #1a1e24;
  border: 1px solid #3a3f4d;
}

scale slider {
  background-color: #F7F1FF;
  border: 1px solid #3a3f4d;
}

progressbar trough {
  background-color: #1a1e24;
  border: 1px solid #3a3f4d;
}

progressbar progress {
  background-color: #7b9ef0;
}

spinbutton {
  background-color: #1a1e24;
  color: #F7F1FF;
  border: 1px solid #3a3f4d;
}

combobox {
  background-color: #1a1e24;
  color: #F7F1FF;
}

tooltip {
  background-color: #121517;
  color: #F7F1FF;
  border: 1px solid #3a3f4d;
}

dialog {
  background-color: #080808;
  color: #F7F1FF;
}

statusbar {
  background-color: #080808;
  color: #b5bfe2;
}

treeview {
  background-color: @theme_base_color;
  color: @theme_text_color;
}

treeview:selected {
  background-color: #1a1e24;
  color: #F7F1FF;
}

.view treeview:selected {
  background-color: rgba(123, 158, 240, 0.35);
  color: #F7F1FF;
}

row {
  background-color: transparent;
  color: @theme_fg_color;
}

row:selected {
  background-color: #1a1e24;
  color: #F7F1FF;
}

row:selected:backdrop {
  background-color: #1a1e24;
  color: #b5bfe2;
}

.view row:selected {
  background-color: rgba(123, 158, 240, 0.35);
  color: #F7F1FF;
}

button.flat {
  background-color: transparent;
}

button.flat:hover {
  background-color: #1a1e24;
}
CSS

    cat > $out/share/themes/Ugly-Red-Cyan/gtk-4.0/gtk.css << 'CSS'
@define-color theme_bg_color #080808;
@define-color theme_fg_color #F7F1FF;
@define-color theme_base_color #080808;
@define-color theme_text_color #F7F1FF;
@define-color theme_selected_bg_color rgba(123, 158, 240, 0.35);
@define-color theme_selected_fg_color #F7F1FF;
@define-color theme_unfocused_bg_color #080808;
@define-color theme_unfocused_fg_color #b5bfe2;
@define-color theme_unfocused_base_color #080808;
@define-color theme_unfocused_text_color #b5bfe2;
@define-color theme_unfocused_selected_bg_color rgba(123, 158, 240, 0.2);
@define-color theme_unfocused_selected_fg_color #b5bfe2;
@define-color borders #3a3f4d;
@define-color unfocused_borders #2d323e;
@define-color accent_color #7b9ef0;
@define-color accent_bg_color #7b9ef0;
@define-color accent_fg_color #080808;
@define-color card_bg_color #121517;
@define-color card_fg_color #F7F1FF;
@define-color popover_bg_color #121517;
@define-color popover_fg_color #F7F1FF;
@define-color window_bg_color #080808;
@define-color window_fg_color #F7F1FF;
@define-color view_bg_color #080808;
@define-color view_fg_color #F7F1FF;
@define-color headerbar_bg_color #080808;
@define-color headerbar_fg_color #F7F1FF;
@define-color headerbar_border_color #3a3f4d;
@define-color sidebar_bg_color #080808;
@define-color sidebar_fg_color #F7F1FF;
@define-color sidebar_backdrop_color #080808;
@define-color sidebar_border_color #3a3f4d;

rubberband {
  background-color: rgba(247, 241, 255, 0.15);
  border: 1px solid #F7F1FF;
}

.sidebar {
  background-color: @sidebar_bg_color;
  color: @sidebar_fg_color;
  border-right: 1px solid @sidebar_border_color;
}

.sidebar:backdrop {
  background-color: @sidebar_backdrop_color;
  color: @theme_unfocused_fg_color;
}

.sidebar scrolledwindow,
.sidebar viewport,
.sidebar row {
  background-color: @sidebar_bg_color;
}

.sidebar scrolledwindow:backdrop,
.sidebar viewport:backdrop,
.sidebar row:backdrop {
  background-color: @sidebar_backdrop_color;
}

.sidebar row:hover {
  background-color: #1a1e24;
}

.sidebar row:selected {
  background-color: #1a1e24;
  color: @sidebar_fg_color;
}

.sidebar row:selected:backdrop {
  background-color: #1a1e24;
  color: @theme_unfocused_fg_color;
}

textview text selection,
entry text selection,
label selection {
  background-color: rgba(123, 158, 240, 0.35);
  color: #F7F1FF;
}

row:selected {
  background-color: #1a1e24;
  color: #F7F1FF;
}

.view row:selected {
  background-color: rgba(123, 158, 240, 0.35);
  color: #F7F1FF;
}

treeview:selected {
  background-color: #1a1e24;
  color: #F7F1FF;
}

.view treeview:selected {
  background-color: rgba(123, 158, 240, 0.35);
  color: #F7F1FF;
}
CSS
  '';

  meta = {
    description = "Dark GTK theme matching ghostty renoir colors";
    license = lib.licenses.mit;
  };
}
