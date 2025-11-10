{ pkgs }:

let
  self = {
    gnomeExtensions.highlight-focus       = pkgs.callPackage ./gnome-shell-extensions/highlight-focus       { };
    gnomeExtensions.useless-gaps          = pkgs.callPackage ./gnome-shell-extensions/useless-gaps          { };
  };
in self
