# NixPkgs Modules Lab

I use this repository to develop and debug modules in `nixpkgs/nixos/modules`.

Typical commands:

```
nix flake update && nom build .#nixosConfigurations.[documenso].config.system.build.vm
nom build .#nixosConfigurations.[documenso].config.system.build.vm
./result/bin/run-nixos-vm
```
