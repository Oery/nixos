# Bezier curves and animations.
{ lib, ... }:
let
  inherit (import ./_lib.nix lib) curve;
in
{
  wayland.windowManager.hyprland.settings = {
    curve = [
      (curve "linear" [
        [
          0.0
          0.0
        ]
        [
          1.0
          1.0
        ]
      ])
      (curve "md3_standard" [
        [
          0.2
          0.0
        ]
        [
          0.0
          1.0
        ]
      ])
      (curve "md3_decel" [
        [
          0.05
          0.7
        ]
        [
          0.1
          1.0
        ]
      ])
      (curve "md3_accel" [
        [
          0.3
          0.0
        ]
        [
          0.8
          0.15
        ]
      ])
      (curve "overshot" [
        [
          0.05
          0.9
        ]
        [
          0.1
          1.1
        ]
      ])
      (curve "crazyshot" [
        [
          0.1
          1.5
        ]
        [
          0.76
          0.92
        ]
      ])
      (curve "hyprnostretch" [
        [
          0.05
          0.9
        ]
        [
          0.1
          1.0
        ]
      ])
      (curve "fluent_decel" [
        [
          0.1
          1.0
        ]
        [
          0.0
          1.0
        ]
      ])
      (curve "easeInOutCirc" [
        [
          0.85
          0.0
        ]
        [
          0.15
          1.0
        ]
      ])
      (curve "easeOutCirc" [
        [
          0.0
          0.55
        ]
        [
          0.45
          1.0
        ]
      ])
      (curve "easeOutExpo" [
        [
          0.16
          1.0
        ]
        [
          0.3
          1.0
        ]
      ])
      (curve "wind" [
        [
          0.05
          0.9
        ]
        [
          0.1
          1.05
        ]
      ])
      (curve "winIn" [
        [
          0.1
          1.1
        ]
        [
          0.1
          1.1
        ]
      ])
      (curve "winOut" [
        [
          0.3
          (-0.3)
        ]
        [
          0.0
          1.0
        ]
      ])
      (curve "liner" [
        [
          1.0
          1.0
        ]
        [
          1.0
          1.0
        ]
      ])
      (curve "smoothOut" [
        [
          0.5
          0.0
        ]
        [
          0.99
          0.99
        ]
      ])
      (curve "smoothIn" [
        [
          0.5
          (-0.5)
        ]
        [
          0.68
          1.5
        ]
      ])
    ];
    animation = [
      {
        leaf = "border";
        enabled = true;
        speed = 10.0;
        bezier = "default";
      }
      {
        leaf = "fade";
        enabled = true;
        speed = 2.5;
        bezier = "md3_decel";
      }
      {
        leaf = "workspaces";
        enabled = true;
        speed = 3.5;
        bezier = "easeOutExpo";
        style = "slide";
      }
      {
        leaf = "specialWorkspace";
        enabled = true;
        speed = 3.0;
        bezier = "md3_decel";
        style = "slidevert";
      }
      {
        leaf = "windows";
        enabled = true;
        speed = 2.0;
        bezier = "wind";
        style = "slide";
      }
      {
        leaf = "windowsIn";
        enabled = true;
        speed = 3.0;
        bezier = "md3_decel";
        style = "slide bottom";
      }
      {
        leaf = "windowsOut";
        enabled = true;
        speed = 2.0;
        bezier = "smoothOut";
        style = "slide";
      }
      {
        leaf = "windowsMove";
        enabled = true;
        speed = 2.0;
        bezier = "wind";
        style = "slide";
      }
      {
        leaf = "layersIn";
        enabled = true;
        speed = 2.0;
        bezier = "md3_decel";
        style = "slide";
      }
      {
        leaf = "layersOut";
        enabled = true;
        speed = 2.0;
        bezier = "smoothOut";
        style = "slide";
      }
      {
        leaf = "border";
        enabled = true;
        speed = 1.0;
        bezier = "liner";
      }
      {
        leaf = "fade";
        enabled = true;
        speed = 2.0;
        bezier = "smoothOut";
      }
      {
        leaf = "fadeLayersIn";
        enabled = false;
        speed = 0.0;
        bezier = "liner";
      }
    ];
  };
}
