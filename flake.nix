{
  description = "A small software environment for your plain-text notes";
  inputs = {
    flake-utils.url = github:numtide/flake-utils;
    emanote.url = github:srid/emanote;
    shellac.url = "github:edrex/shellac";
    shellac.inputs.flake-utils.follows = "flake-utils";
  };
  nixConfig = {
    binaryCaches = [ "https://srid.cachix.org" ];
    binaryCachePublicKeys =
      [ "srid.cachix.org-1:MTQ6ksbfz3LBMmjyPh0PLmos+1x+CdtJxA/J2W+PQxI=" ];
  };
  outputs = { self, nixpkgs, flake-utils, emanote, shellac, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # follow https://zimbatm.com/notes/1000-instances-of-nixpkgs
        p = let 
          npkgs = nixpkgs.legacyPackages.${system}; # hack around scope rules
        in rec {
          nixpkgs = npkgs;
          emanote = emanote.defaultPackage.${system};
          neovim-notes = nixpkgs.wrapNeovimUnstable nixpkgs.neovim-unwrapped
            (nixpkgs.neovimUtils.makeNeovimConfig {
              plugins = with nixpkgs.vimPlugins; [{ plugin = telescope-nvim; }];
            });
        };
        shellPkgs = with p.nixpkgs; [ tydra tmux emanote links2 p.neovim-notes ];
        terminalBrowser = "${p.nixpkgs.links2}/bin/links";
      in rec {
        menu = shellac.lib.${system}.mkTydraMenu
          (import ./menu.nix { inherit terminalBrowser shellPkgs; });
        defaultApp = apps.main;
        defaultPackage = defaultApp.script;
        apps.main = p.nixpkgs.writeShellApplication {
          name = "notesflow";
          runtimeInputs = shellPkgs;
          text = ''
            # set -xe
            TMUX_SOCKET="notesflow.tmux.socket"
            TMUX_SESSION="$(basename "$PWD")-$(echo "$PWD" | sha1sum | cut -f1 -d ' ')"
            SHELL="${"SHELL:-bash"}"
            export TMUX_SOCKET TMUX_SESSION
            tmux -L "$TMUX_SOCKET" has-session -t "$TMUX_SESSION" || tmux -L "$TMUX_SOCKET" new-session -s "$TMUX_SESSION" -dAD -n emanote emanote run --port 7072
            tydra --ignore-exit-status ${menu}
          '';
        };
        devShell = p.nixpkgs.mkShell { packages = shellPkgs; };
      });
}
