{ ... }:
{
  services.quiqr-server = {
    enable = true;
  };

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096; # use 2048MiB memory
      cores = 3; # use 3 cpu cores
    };
  };

}
