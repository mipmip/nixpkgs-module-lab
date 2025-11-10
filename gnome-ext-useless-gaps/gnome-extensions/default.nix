{ config, lib, pkgs, unstable, ... }:

let
  #cfg = config.desktopConf.gnome;

  mipmip_pkg = import (./pkgs){inherit pkgs;};

    gnomeExtensionsWithOutConf = [
      #mipmip_pkg.gnomeExtensions.custom-menu-panel
        pkgs.gnomeExtensions.emoji-copy
    #    pkgs.gnomeExtensions.caffeine
    #    #pkgs.gnomeExtensions.espresso
    #    pkgs.gnomeExtensions.show-favorite-apps
    #    pkgs.gnomeExtensions.appindicator
    #    pkgs.gnomeExtensions.spotify-tray
    #    pkgs.gnomeExtensions.wayland-or-x11
    #    pkgs.gnomeExtensions.clipboard-indicator
      #pkgs.gnomeExtensions.tailscale-status
    ];

  gnomeExtensions = map (ext: { extpkg = ext; } ) gnomeExtensionsWithOutConf ++ [
    (import ./shell-ext-useless-gaps.nix { lib = lib; mipmip_pkg = mipmip_pkg; inherit unstable; })
  ];

  dconfEnabledExtensions = {
    "org/gnome/shell" = {
      enabled-extensions = map (ext: ext.extpkg.extensionUuid) gnomeExtensions ++ [
      ];
    };
  };

  dconfExtConfs = builtins.listToAttrs (builtins.catAttrs "dconf" gnomeExtensions);
  recursiveMerge = import ./recursive-merge.nix {lib = lib;};
in
{

  home.packages = map (ext: ext.extpkg) gnomeExtensions;
  dconf.settings = recursiveMerge [dconfEnabledExtensions dconfExtConfs];
}
