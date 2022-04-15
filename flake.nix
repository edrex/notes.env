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
          neovim-notes = final.wrapNeovimUnstable final.neovim-unwrapped (final.neovimUtils.makeNeovimConfig {
            plugins = with final.vimPlugins; [
              { plugin = telescope-nvim; }
            ];
          });
        });
        shellPkgs = with pkgs; [
          tydra
          tmux
          emanote
          links2
          neovim-notes
        ];
        terminalBrowser = "${pkgs.links2}/bin/links";

        

      in rec {
        lib = pkgs.callPackage ./lib.nix {};
        menu = lib.mkTydraMenu (import ./menu.nix { inherit terminalBrowser shellPkgs;});
        defaultApp = apps.main;
        defaultPackage = defaultApp.script;
        apps.main = pkgs.writeShellApplication {
          name = "notesflow";
          runtimeInputs = shellPkgs;
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
        devShell = pkgs.mkShell {
          packages = shellPkgs;
        };
      }
    );
}
