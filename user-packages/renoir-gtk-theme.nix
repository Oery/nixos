{ pkgs, lib }:

let
  themeName = "Renoir";
in
pkgs.stdenvNoCC.mkDerivation {
  pname = "renoir-gtk-theme";
  version = "2.0";

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    themeDir="$out/share/themes/${themeName}"
    install -d "$themeDir/gtk-3.0" "$themeDir/gtk-4.0"

    cat > "$themeDir/index.theme" <<'EOF'
[Desktop Entry]
Type=X-GNOME-Metatheme
Name=Renoir
Comment=Monochrome dark GTK theme

[X-GNOME-Metatheme]
GtkTheme=Renoir
ButtonLayout=menu:minimize,maximize,close
EOF

    cat > "$themeDir/gtk-3.0/gtk.css" <<'CSS'
/* Keep Adwaita's widget metrics, assets and state handling.  A theme made only
 * of colour overrides leaves many GTK widgets unstyled; a wildcard background
 * rule is even worse because it paints over applications' internal widgets. */
@import url("resource:///org/gtk/libgtk/theme/Adwaita/gtk-contained-dark.css");

@define-color theme_bg_color #080808;
@define-color theme_fg_color #f7f7f7;
@define-color theme_base_color #080808;
@define-color theme_text_color #f7f7f7;
@define-color theme_selected_bg_color #242424;
@define-color theme_selected_fg_color #f7f7f7;
@define-color theme_unfocused_bg_color #080808;
@define-color theme_unfocused_fg_color #b8b8b8;
@define-color theme_unfocused_base_color #080808;
@define-color theme_unfocused_text_color #b8b8b8;
@define-color theme_unfocused_selected_bg_color #171717;
@define-color theme_unfocused_selected_fg_color #b8b8b8;
@define-color borders #343434;
@define-color unfocused_borders #262626;
@define-color warning_color #f7f7f7;
@define-color error_color #f7f7f7;
@define-color success_color #f7f7f7;
@define-color theme_link_color #f7f7f7;
@define-color theme_visited_link_color #b8b8b8;

.background,
window,
dialog {
  color: @theme_fg_color;
  background-color: @theme_bg_color;
}

.background:backdrop,
window:backdrop {
  color: @theme_unfocused_fg_color;
  background-color: @theme_unfocused_bg_color;
}

.view,
iconview,
.view text,
iconview text,
textview text,
treeview {
  color: @theme_text_color;
  caret-color: @theme_text_color;
  background-color: @theme_base_color;
}

.view:backdrop,
iconview:backdrop,
.view text:backdrop,
iconview text:backdrop,
textview text:backdrop,
treeview:backdrop {
  color: @theme_unfocused_text_color;
  background-color: @theme_unfocused_base_color;
}

.view:selected,
iconview:selected,
.view text:selected,
iconview text:selected,
textview text:selected,
treeview:selected,
row:selected,
label selection,
entry selection {
  color: @theme_selected_fg_color;
  background-color: @theme_selected_bg_color;
}

.view:selected:backdrop,
iconview:selected:backdrop,
.view text:selected:backdrop,
iconview text:selected:backdrop,
textview text:selected:backdrop,
treeview:selected:backdrop,
row:selected:backdrop {
  color: @theme_unfocused_selected_fg_color;
  background-color: @theme_unfocused_selected_bg_color;
}

treeview.view header button,
treeview header button {
  background-image: none;
  background-color: #101010;
  border-color: @borders;
}

treeview.view header button:hover,
treeview header button:hover {
  background-color: #171717;
  border-color: #666666;
}

headerbar,
.titlebar,
toolbar,
menubar {
  color: @theme_fg_color;
  background-image: none;
  background-color: #080808;
  border-color: @borders;
}

headerbar:backdrop,
.titlebar:backdrop,
toolbar:backdrop,
menubar:backdrop {
  color: @theme_unfocused_fg_color;
  background-color: #080808;
  border-color: @unfocused_borders;
}

button {
  color: @theme_fg_color;
  background-image: none;
  background-color: #080808;
  border-color: @borders;
}

button:hover {
  background-color: #171717;
  border-color: #666666;
}

button.suggested-action,
button.destructive-action {
  color: @theme_selected_fg_color;
  background-image: none;
  background-color: @theme_selected_bg_color;
  border-color: @theme_selected_bg_color;
}

button:active,
button:checked {
  color: @theme_selected_fg_color;
  background-image: none;
  background-color: @theme_selected_bg_color;
  border-color: @theme_selected_bg_color;
}

button:disabled {
  color: #777777;
  background-color: #080808;
  border-color: #242424;
}

button.suggested-action:disabled,
button.destructive-action:disabled {
  color: #777777;
  background-image: none;
  background-color: #101010;
  border-color: #242424;
  box-shadow: none;
}

button.flat,
button.titlebutton {
  background-color: transparent;
}

button.flat:hover,
button.titlebutton:hover {
  background-color: #171717;
}

entry,
spinbutton,
combobox button {
  color: @theme_text_color;
  background-image: none;
  background-color: @theme_base_color;
  border-color: @borders;
}

entry:focus,
spinbutton:focus,
combobox button:focus {
  border-color: #a0a0a0;
  box-shadow: inset 0 0 0 1px #a0a0a0;
}

menu,
.menu,
popover,
popover.background {
  color: @theme_fg_color;
  background-color: #101010;
  border-color: @borders;
}

menuitem:hover,
modelbutton:hover,
row:hover {
  background-color: #171717;
}

.sidebar,
.sidebar viewport,
.sidebar scrolledwindow,
placessidebar list {
  color: @theme_fg_color;
  background-color: #080808;
  border-color: @borders;
}

notebook,
notebook stack,
notebook > stack,
scrolledwindow > viewport,
list,
list row {
  background-image: none;
  background-color: @theme_bg_color;
}

notebook header,
notebook tab {
  background-image: none;
  background-color: #080808;
  border-color: @borders;
}

notebook tab:checked {
  color: @theme_fg_color;
  background-color: #080808;
}

check,
radio,
switch,
scale trough,
progressbar trough {
  color: @theme_fg_color;
  background-image: none;
  background-color: #080808;
  border-color: @borders;
  box-shadow: none;
}

check:checked,
check:indeterminate,
radio:checked,
radio:indeterminate,
switch:checked,
scale highlight,
progressbar progress {
  color: @theme_selected_fg_color;
  background-image: none;
  background-color: @theme_selected_bg_color;
  border-color: @theme_selected_bg_color;
  box-shadow: none;
}

levelbar block {
  background-image: none;
  background-color: #080808;
  border-color: @borders;
}

levelbar block.filled {
  background-color: @theme_selected_bg_color;
  border-color: @theme_selected_bg_color;
}

*:link,
link,
link:visited,
button.link,
button.link:hover,
button.link:active,
button.link:checked,
button:link > label,
button:visited > label,
button:link > label:active,
button:visited > label:active {
  color: @theme_link_color;
  background-color: transparent;
}

*:selected:focus,
*:focus-visible {
  outline-color: #a0a0a0;
}

notebook header tabs tab:checked {
  box-shadow: inset 0 -2px #f2f2f2;
}

notebook > header.top > tabs > tab:checked {
  box-shadow: inset 0 -2px #f2f2f2;
}

notebook > header.bottom > tabs > tab:checked {
  box-shadow: inset 0 2px #f2f2f2;
}

notebook > header.left > tabs > tab:checked {
  box-shadow: inset -2px 0 #f2f2f2;
}

notebook > header.right > tabs > tab:checked {
  box-shadow: inset 2px 0 #f2f2f2;
}

scrollbar {
  background-color: transparent;
}

scrollbar slider {
  background-color: #4a4a4a;
  border-color: transparent;
}

scrollbar slider:hover,
scrollbar slider:active {
  background-color: #888888;
}

tooltip,
tooltip.background {
  color: @theme_fg_color;
  background-color: #101010;
  border-color: #666666;
}

/* Accent-bearing states in Adwaita use selectors more specific than the base
 * widget rules above.  Keep these overrides state-scoped: unlike a global
 * widget background, they cannot paint over application layout containers. */
*:selected:selected:selected {
  color: @theme_selected_fg_color;
  background-image: none;
  background-color: @theme_selected_bg_color;
}

check:checked:checked,
check:indeterminate:indeterminate,
radio:checked:checked,
radio:indeterminate:indeterminate,
switch:checked:checked {
  color: @theme_selected_fg_color;
  background-image: none;
  background-color: @theme_selected_bg_color;
  border-color: @theme_selected_bg_color;
}

entry:focus,
spinbutton:focus:not(.vertical),
treeview entry:focus,
treeview entry.flat:focus {
  outline-color: #a0a0a0;
  border-color: #a0a0a0;
  box-shadow: inset 0 0 0 1px #a0a0a0;
}

entry image:active,
spinbutton:not(.vertical) image:active {
  color: @theme_fg_color;
}

menu menuitem:hover,
.menu menuitem:hover,
.context-menu menuitem:hover {
  color: @theme_selected_fg_color;
  background-color: @theme_selected_bg_color;
}

menubar > menuitem:hover,
.menubar > menuitem:hover {
  color: @theme_fg_color;
  box-shadow: inset 0 -2px @theme_fg_color;
}

.selection-mode .titlebar:not(headerbar),
.selection-mode.titlebar:not(headerbar),
.selection-mode headerbar,
headerbar.selection-mode {
  color: @theme_fg_color;
  background-image: none;
  background-color: #080808;
  border-color: #666666;
  box-shadow: inset 0 -1px #666666;
}

infobar.info,
infobar.question,
infobar.warning,
infobar.error {
  color: @theme_fg_color;
  background-image: none;
  background-color: #080808;
  border-color: #666666;
}

paned > separator:selected,
treeview.view.progressbar,
treeview.view acceleditor > label {
  color: @theme_selected_fg_color;
  background-image: none;
  background-color: @theme_selected_bg_color;
}

.rubberband,
rubberband {
  background-color: alpha(@theme_fg_color, 0.15);
  border-color: @theme_fg_color;
}

separator {
  color: @borders;
  background-image: none;
  background-color: @borders;
}
CSS

    cat > "$themeDir/gtk-4.0/gtk.css" <<'CSS'
/* This file is intentionally an override layer.  GTK already supplies widget
 * geometry and assets before Home Manager imports a GTK 4 theme as user CSS.
 * Importing Default-dark again here also restyles libadwaita at user priority,
 * creating doubled metrics and the stack of grey surfaces Renoir is avoiding. */

@define-color theme_bg_color #080808;
@define-color theme_fg_color #f4f4f4;
@define-color theme_base_color #080808;
@define-color theme_text_color #f4f4f4;
@define-color theme_selected_bg_color #242424;
@define-color theme_selected_fg_color #f4f4f4;
@define-color theme_unfocused_bg_color #080808;
@define-color theme_unfocused_fg_color #a8a8a8;
@define-color theme_unfocused_base_color #080808;
@define-color theme_unfocused_text_color #a8a8a8;
@define-color theme_unfocused_selected_bg_color #171717;
@define-color theme_unfocused_selected_fg_color #a8a8a8;
@define-color borders #343434;
@define-color unfocused_borders #262626;

/* Named colours keep ordinary GTK 4 applications on the same palette. */
@define-color accent_color #f2f2f2;
@define-color accent_bg_color #242424;
@define-color accent_fg_color #f4f4f4;
@define-color destructive_color #f2f2f2;
@define-color destructive_bg_color #f2f2f2;
@define-color destructive_fg_color #080808;
@define-color success_color #f2f2f2;
@define-color success_bg_color #f2f2f2;
@define-color success_fg_color #080808;
@define-color warning_color #f2f2f2;
@define-color warning_bg_color #f2f2f2;
@define-color warning_fg_color #080808;
@define-color error_color #f2f2f2;
@define-color error_bg_color #f2f2f2;
@define-color error_fg_color #080808;
@define-color window_bg_color #080808;
@define-color window_fg_color #f4f4f4;
@define-color view_bg_color #080808;
@define-color view_fg_color #f4f4f4;
@define-color headerbar_bg_color #080808;
@define-color headerbar_fg_color #f4f4f4;
@define-color headerbar_border_color #343434;
@define-color headerbar_backdrop_color #080808;
@define-color headerbar_shade_color rgba(255, 255, 255, 0.10);
@define-color card_bg_color #080808;
@define-color card_fg_color #f4f4f4;
@define-color card_shade_color rgba(255, 255, 255, 0.10);
@define-color dialog_bg_color #080808;
@define-color dialog_fg_color #f4f4f4;
@define-color popover_bg_color #101010;
@define-color popover_fg_color #f4f4f4;
@define-color shade_color rgba(0, 0, 0, 0.55);
@define-color scrollbar_outline_color #000000;
@define-color sidebar_bg_color #080808;
@define-color sidebar_fg_color #f4f4f4;
@define-color sidebar_backdrop_color #080808;
@define-color sidebar_border_color #343434;
@define-color link_color #f4f4f4;
@define-color visited_link_color #b8b8b8;

/* Libadwaita 1.8+ resolves these custom properties after named colours. */
:root {
  --accent-color: #f2f2f2;
  --accent-bg-color: #242424;
  --accent-fg-color: #f4f4f4;
  --destructive-color: #f2f2f2;
  --destructive-bg-color: #f2f2f2;
  --destructive-fg-color: #080808;
  --success-color: #f2f2f2;
  --success-bg-color: #f2f2f2;
  --success-fg-color: #080808;
  --warning-color: #f2f2f2;
  --warning-bg-color: #f2f2f2;
  --warning-fg-color: #080808;
  --error-color: #f2f2f2;
  --error-bg-color: #f2f2f2;
  --error-fg-color: #080808;
  --window-bg-color: #080808;
  --window-fg-color: #f4f4f4;
  --view-bg-color: #080808;
  --view-fg-color: #f4f4f4;
  --headerbar-bg-color: #080808;
  --headerbar-fg-color: #f4f4f4;
  --headerbar-backdrop-color: #080808;
  --headerbar-shade-color: rgba(255, 255, 255, 0.10);
  --headerbar-darker-shade-color: #000000;
  --sidebar-bg-color: #080808;
  --sidebar-fg-color: #f4f4f4;
  --sidebar-backdrop-color: #080808;
  --secondary-sidebar-bg-color: #080808;
  --secondary-sidebar-backdrop-color: #080808;
  --card-bg-color: #080808;
  --card-fg-color: #f4f4f4;
  --card-shade-color: rgba(255, 255, 255, 0.10);
  --dialog-bg-color: #080808;
  --dialog-fg-color: #f4f4f4;
  --popover-bg-color: #101010;
  --popover-fg-color: #f4f4f4;
  --border-color: rgba(255, 255, 255, 0.18);
  --shade-color: rgba(0, 0, 0, 0.55);
  --active-toggle-bg-color: #242424;
  --active-toggle-fg-color: #f4f4f4;
}

.background,
window,
dialog,
.view,
iconview,
textview > text,
columnview,
list,
list > row,
listview,
gridview,
treeview,
headerbar,
.titlebar,
toolbar,
.toolbar,
menubar,
.sidebar,
.sidebar viewport,
.sidebar scrolledwindow,
placessidebar list,
.sidebar-pane,
.content-pane,
.navigation-sidebar.background,
notebook,
notebook > stack,
notebook > header,
notebook > header tab {
  color: @theme_fg_color;
  background-color: @theme_bg_color;
}

.view,
iconview,
textview > text,
columnview,
list,
listview,
gridview,
treeview {
  caret-color: @theme_text_color;
}

columnview.view > header > button,
columnview > header > button,
treeview.view > header > button,
treeview header button {
  background-image: none;
  background-color: #101010;
  border-color: @borders;
}

columnview.view > header > button:hover,
columnview > header > button:hover,
treeview.view > header > button:hover,
treeview header button:hover {
  background-color: #171717;
  border-color: #666666;
}

.background:backdrop,
window:backdrop,
.view:backdrop,
iconview:backdrop,
textview > text:backdrop,
columnview:backdrop,
list:backdrop,
listview:backdrop,
gridview:backdrop,
treeview:backdrop,
headerbar:backdrop,
.titlebar:backdrop,
toolbar:backdrop,
menubar:backdrop {
  color: @theme_unfocused_fg_color;
  background-color: @theme_unfocused_bg_color;
}

headerbar,
.titlebar,
toolbar,
menubar {
  border-color: @borders;
  background-image: none;
  box-shadow: none;
}

/* Toolbar controls belong to the canvas until interaction reveals them. */
headerbar button,
toolbar button,
.toolbar button,
toolbarview > .top-bar button,
button.flat,
button.titlebutton {
  background-image: none;
  background-color: transparent;
  box-shadow: none;
}

button {
  color: @theme_fg_color;
  background-image: none;
  background-color: #080808;
  border-color: @borders;
  box-shadow: none;
}

button:hover,
headerbar button:hover,
toolbar button:hover,
.toolbar button:hover,
toolbarview > .top-bar button:hover,
button.flat:hover,
button.titlebutton:hover,
modelbutton:hover,
row:hover {
  background-color: #171717;
  border-color: #666666;
}

button.suggested-action,
button.destructive-action,
button:active,
button:checked {
  color: @theme_selected_fg_color;
  background-image: none;
  background-color: @theme_selected_bg_color;
  border-color: @theme_selected_bg_color;
}

button:disabled {
  color: #707070;
  background-color: #080808;
  border-color: #242424;
}

button.suggested-action:disabled,
button.destructive-action:disabled {
  color: #707070;
  background-image: none;
  background-color: #101010;
  border-color: #242424;
  box-shadow: none;
}

entry,
spinbutton,
dropdown > button,
combobox > box > button {
  color: @theme_text_color;
  background-image: none;
  background-color: #080808;
  border-color: @borders;
  box-shadow: none;
}

entry:focus-within,
spinbutton:focus-within,
dropdown > button:focus,
treeview entry:focus-within,
treeview entry.flat:focus-within {
  outline-color: #a0a0a0;
  border-color: #a0a0a0;
  box-shadow: inset 0 0 0 1px #a0a0a0;
}

popover > contents,
popover.background > contents,
menu,
.menu,
tooltip.background {
  color: @theme_fg_color;
  background-color: #101010;
  border-color: @borders;
}

.view:selected,
iconview:selected,
columnview row:selected,
listview row:selected,
gridview > child:selected,
treeview:selected,
row:selected,
textview > text > selection,
entry > text > selection,
label > selection,
*:selected:selected:selected {
  color: @theme_selected_fg_color;
  background-image: none;
  background-color: @theme_selected_bg_color;
}

columnview row:selected:backdrop,
listview row:selected:backdrop,
gridview > child:selected:backdrop,
treeview:selected:backdrop,
row:selected:backdrop {
  color: @theme_unfocused_selected_fg_color;
  background-color: @theme_unfocused_selected_bg_color;
}

notebook > header tab:checked {
  color: @theme_fg_color;
  background-color: #080808;
  box-shadow: inset 0 -2px #f2f2f2;
}

check,
radio,
switch,
scale > trough,
progressbar > trough,
levelbar > trough > block {
  color: @theme_fg_color;
  background-image: none;
  background-color: #080808;
  border-color: @borders;
  box-shadow: none;
}

check:checked,
check:indeterminate,
radio:checked,
radio:indeterminate,
switch:checked,
scale > trough > highlight,
progressbar > trough > progress,
levelbar > trough > block.filled,
check:checked:checked,
check:indeterminate:indeterminate,
radio:checked:checked,
radio:indeterminate:indeterminate,
switch:checked:checked {
  color: @theme_selected_fg_color;
  background-image: none;
  background-color: @theme_selected_bg_color;
  border-color: @theme_selected_bg_color;
  box-shadow: none;
}

link,
link:visited,
button.link,
button.link:hover,
button.link:active,
button.link:checked,
button.link > label,
button.link:active > label {
  color: @link_color;
  background-color: transparent;
}

scrollbar {
  background-color: transparent;
}

scrollbar slider {
  background-color: #4a4a4a;
  border-color: transparent;
}

scrollbar slider:hover,
scrollbar slider:active {
  background-color: #888888;
}

/* Keep application chrome monochrome without filtering photos and previews. */
image {
  -gtk-icon-filter: grayscale(1);
}

*:focus-visible {
  outline-color: #a0a0a0;
}

infobar.info,
infobar.question,
infobar.warning,
infobar.error {
  color: @theme_fg_color;
  background-image: none;
  background-color: #080808;
  border-color: #666666;
}

columnview.view.progressbar,
treeview.view.progressbar,
columnview.view acceleditor > label,
treeview.view acceleditor > label {
  color: @theme_selected_fg_color;
  background-image: none;
  background-color: @theme_selected_bg_color;
}

rubberband {
  background-color: alpha(@theme_fg_color, 0.15);
  border-color: @theme_fg_color;
}

separator,
paned > separator {
  color: @borders;
  background-image: none;
  background-color: @borders;
}

paned > separator:selected {
  color: #666666;
  background-color: #666666;
}
CSS

    runHook postInstall
  '';

  meta = {
    description = "Renoir monochrome dark theme for GTK 3 and GTK 4";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
