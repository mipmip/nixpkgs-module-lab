{ config, lib, pkgs, ... }:{

  # Pre 25.11
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # As of 25.11
  #  services.displayManager.gdm.enable = true;
  #  services.desktopManager.gnome.enable = true;

  # To disable installing GNOME's suite of applications
  # and only be left with GNOME shell.
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];

  home-manager.users.nixos = { pkgs, ... }: {
    home.packages = [ pkgs.ghostty ];
    imports = [
      ./gnome-extensions
    ];

    home.stateVersion = "25.05";
  };
}
