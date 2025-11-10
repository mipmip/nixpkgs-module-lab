{ unstable, mipmip_pkg, ... }:
{
  extpkg = mipmip_pkg.gnomeExtensions.highlight-focus;
  #  dconf = {
  #    name = "org/gnome/shell/extensions/highlight-focus";
  #    value = {
  #      gap-size = 25;
  #      margin-bottom = 25;
  #      margin-left = 0;
  #      margin-right = 0;
  #      margin-top = 0;
  #      no-gap-when-maximized = false;
  #    };
  #  };
}
