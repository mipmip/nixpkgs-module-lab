{ config, lib, pkgs, unstable, ... }:

let
  mipmip_pkg = import (./pkgs){inherit pkgs;};

    gnomeExtensionsWithOutConf = [
        pkgs.gnomeExtensions.emoji-copy
    ];

  gnomeExtensions = map (ext: { extpkg = ext; } ) gnomeExtensionsWithOutConf ++ [
    (import ./shell-ext-useless-gaps.nix { lib = lib; mipmip_pkg = mipmip_pkg; inherit unstable; })
    (import ./shell-ext-highlight-focus.nix { lib = lib; mipmip_pkg = mipmip_pkg; inherit unstable; })
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
