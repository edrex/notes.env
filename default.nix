{ pkgs, emanote, shellac }:
  let
    neovim-notes = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped
      (pkgs.neovimUtils.makeNeovimConfig {
        plugins = with pkgs.vimPlugins; [{ plugin = telescope-nvim; }];
      });
    shellPkgs = [ pkgs.tydra pkgs.tmux emanote pkgs.links2 neovim-notes ];
    terminalBrowser = "${pkgs.links2}/bin/links";
    shellStuff = shellac.lib.mkShell pkgs;
  in rec {
    menu = shellStuff.mkTydraMenu
      (import ./menu.nix { inherit terminalBrowser shellPkgs; });
    # TODO: replace tmux with runit in shellac
    app = pkgs.writeShellApplication rec {
      name = "noteable";
      runtimeInputs = shellPkgs;
      text = ''
        # set -x
        TMUX_SOCKET="${name}.tmux.socket"
        TMUX_SESSION="$(basename "$PWD")-$(echo "$PWD" | sha1sum | cut -f1 -d ' ')"
        SHELL="${"SHELL:-bash"}"
        export TMUX_SOCKET TMUX_SESSION
        tmux -L "$TMUX_SOCKET" has-session -t "$TMUX_SESSION" || tmux -L "$TMUX_SOCKET" new-session -s "$TMUX_SESSION" -dAD -n emanote emanote run --port 7072
        tydra --ignore-exit-status ${menu}
      '';
    };
    devShell = pkgs.mkShell { packages = shellPkgs; };
}