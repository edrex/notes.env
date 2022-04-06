{
  description = "An small software environment for working with a notes directory";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    emanote.url = "github:srid/emanote";
  };
  nixConfig = {
    binaryCaches = [ "https://srid.cachix.org" ];
    binaryCachePublicKeys = [ "srid.cachix.org-1:MTQ6ksbfz3LBMmjyPh0PLmos+1x+CdtJxA/J2W+PQxI=" ];
  };
  outputs = inputs@{ self, nixpkgs, flake-utils, emanote, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        defaultApp = apps.main;
        defaultPackage = defaultApp.script;
        apps = {
          main = rec {
            type = "app";
            menu = ((pkgs.formats.yaml {}).generate "menu.yaml" {
              pages = {
                root = {
                  title = "Hi";
                  groups = [
                    {
                      title = "Favorites";
                      entries = [
                        {
                          shortcut = "s";
                          title = "Serve";
                          command = "${emanote.defaultPackage.${system}}/bin/emanote run --port 7072";
                          # mode = "background";
                        }
                      ];
                    }
                  ];
                };
              };
            });
            script = pkgs.writeShellApplication {
              name = "notesdir";
              text = ''
                set -xe
                ${pkgs.tydra}/bin/tydra ${menu}
              '';
            };
            program = "${script}/bin/notesdir";
          };
        };
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.tydra
            emanote.defaultPackage.${system}
          ];
        };
      }
    );
}
