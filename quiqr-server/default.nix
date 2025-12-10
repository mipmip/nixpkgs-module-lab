{ ... }:
let
  htpassword = ./quiqr-htpasswd; # (technative:technative)
in
{
  services.quiqr-server = {
    enable = true;
    nginx = {
      enable = true;
      domain = "localhost";
      basicAuthFile = htpassword;
    };
  };

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096; # use 2048MiB memory
      cores = 3; # use 3 cpu cores
    };
  };

}
