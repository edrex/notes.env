{
  description = "A small software environment for your plain-text notes";
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
      let
        pkgs = nixpkgs.legacyPackages.${system}.extend (final: prev: {
          emanote = emanote.defaultPackage.${system};
        });
        terminalBrowser = "${pkgs.links2}/bin/links";
      in rec {
        defaultApp = apps.main;
        defaultPackage = defaultApp.script;
        apps = {
          main = rec {
            type = "app";
            menu = ((pkgs.formats.yaml {}).generate "menu.yaml" {
              global = {
              };
              pages = {
                root = {
                  title = "notesdir";
                  groups = [
                    {
                      title = "Favorites";
                      entries = [
                        {
                          shortcut = "t";
                          title = "tmux";
                          return = "tmux";
                        }
                        {
                          shortcut = "`";
                          title = "shell";
                          command = "fish";
                        }
                        {
                          shortcut = "b";
                          title = "browsers";
                          command = "${terminalBrowser} http://localhost:7072";
                        }
                      ];
                    }
                  ];
                };
                tmux = {
                  title = "tmux";
                  groups = [
                    {
                      entries = [
                        {
                          shortcut = "a";
                          title = "attach (press C-b d to return to this menu!)";
                          command = "tmux -L \"$TMUX_SOCKET\" a -t \"$TMUX_SESSION\"";
                          return = "root";
                        }
                        {
                          shortcut = "q";
                          title = "return to main menu";
                          return = "root";
                        }
                      ];
                    }
                  ];
                };
              };
            });
            # TODO: pull out bin/notesmenu
            # TODO: pull out envmux script
            # TODO: display tmux status
            # TODO: load .env (port number etc) (or just check for existing value before setting env vars)
            script = pkgs.writeShellApplication {
              name = "notesflow";
              runtimeInputs = with pkgs; [
                tydra
                tmux
                emanote
                terminalBrowser
              ];
              text = ''
                set -xe
                TMUX_SOCKET="notesflow.tmux.socket"
                TMUX_SESSION="$(basename "$PWD")-$(echo "$PWD" | sha1sum | cut -f1 -d ' ')"
                SHELL="${SHELL:-bash}"
                export TMUX_SOCKET TMUX_SESSION
                tmux -L "$TMUX_SOCKET" has-session -t "$TMUX_SESSION" || tmux -L "$TMUX_SOCKET" new-session -s "$TMUX_SESSION" -dAD -n emanote emanote run --port 7072
                tydra --ignore-exit-status ${menu}
              '';
            };
            program = "${script}/bin/notesflow";
          };
        };
      }
    );
}
