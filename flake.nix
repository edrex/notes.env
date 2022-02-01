{
  description = "Notes bundle";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    emanote.url = "github:srid/emanote";
    nixpkgs.follows = "emanote/nixpkgs";
    flake-utils.follows = "emanote/flake-utils";
  };

  # nixConfig = {
  #   binaryCaches = [ "https://srid.cachix.org" ];
  #   binaryCachePublicKeys = [ "srid.cachix.org-1:MTQ6ksbfz3LBMmjyPh0PLmos+1x+CdtJxA/J2W+PQxI=" ];
  # };

  outputs = { self, nixpkgs, flake-utils, emanote }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        defaultApp = apps.live;
        apps = {
          live = rec {
            type = "app";
            # '' is required for escaping ${} in nix
            script = pkgs.writeShellApplication {
              name = "emanoteRun.sh";
              text = ''
                set -xe
                export PORT="''${EMANOTE_PORT:-7072}"
                ${emanote.defaultPackage.${system}}/bin/emanote run --port "$PORT"
              '';
            };
            program = "${script}/bin/emanoteRun.sh";
          };
        };
        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.nixpkgs-fmt ];
        };
      }
    );
}
