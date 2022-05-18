{
  description = "A small software environment for your plain-text notes";
  inputs = {
    flake-utils.url = github:numtide/flake-utils;
    emanote.url = github:srid/emanote;
    shellac.url = "github:edrex/shellac";
  };
  nixConfig = {
    binaryCaches = [ "https://srid.cachix.org" ];
    binaryCachePublicKeys =
      [ "srid.cachix.org-1:MTQ6ksbfz3LBMmjyPh0PLmos+1x+CdtJxA/J2W+PQxI=" ];
  };
  outputs = { self, nixpkgs, flake-utils, emanote, shellac, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system}; 
      in rec {
        lib = import ./. {
          inherit pkgs shellac;
          emanote = emanote.defaultPackage.${system};
        };
        defaultApp = lib.shell;
        defaultPackage = defaultApp;
        devShell = lib.devShell;
      });
}
