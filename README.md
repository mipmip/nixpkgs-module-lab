# NixPkgs Modules Lab

I use this repository to develop and debug modules in `nixpkgs/nixos/modules`.

Typical commands:

```
export QEMU_NET_OPTS="hostfwd=tcp:127.0.0.1:2222-:22,hostfwd=tcp:127.0.0.1:8888-:80,hostfwd=tcp:127.0.0.1:5150-:5150"
nix flake update && nom build .#nixosConfigurations.[documenso].config.system.build.vm
nom build .#nixosConfigurations.[documenso].config.system.build.vm
./result/bin/run-nixos-vm
```
