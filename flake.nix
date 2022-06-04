{
  description = "A small software environment for your plain-text notes";
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs.follows = "nixpkgs";
    emanote.url = github:srid/emanote;
    shellac.inputs.nixpkgs.follows = "nixpkgs";
    shellac.url = "github:edrex/shellac";
    nixpkgs.url = "nixpkgs";
  };
  nixConfig = {
    extra-substituters = "https://cache.garnix.io";
    extra-trusted-public-keys = "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=";
  };
  outputs = { self, nixpkgs, flake-parts, shellac, ... }:
    flake-parts.lib.mkFlake {inherit self; } {
      systems = [ "x86_64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: let
        lib = import ./. {
          inherit pkgs shellac;
          emanote = inputs'.emanote.packages.default;
        };
      in rec {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.
        packages.default = lib.app;
        devShells.default = lib.devShell;
      };
    };
}
