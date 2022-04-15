{shellPkgs, terminalBrowser}:
{
  global = {
    layout = "columns";
  };
  pages = {
    root = {
      title = "notesdir";
      groups = [
        {
          title = "Tools";
          entries = [
            {
              shortcut = "e";
              title = "Editor (neovim)";
              command = "nvim";
              return = true;
            }
            {
              shortcut = "`";
              title = "shell";
              command = "fish";
              return = true;
            }
            {
              shortcut = "b";
              title = "browse notes";
              command = "${terminalBrowser} http://localhost:7072";
              return = true;
            }
          ];
        }
        {
          title = "Services";
          entries = [
            {
              shortcut = "s";
              title = "tmux attach (C-b d to detach)";
              command = "tmux -L \"$TMUX_SOCKET\" a -t \"$TMUX_SESSION\"";
              return = "root";
            }
            {
              shortcut = "q";
              title = "quit and stop env services";
              command = "tmux -L \"$TMUX_SOCKET\" kill-session -t \"$TMUX_SESSION\"";
              return = false;
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
              shortcut = ".";
              title = "return to main menu";
              return = "root";
            }
          ];
        }
      ];
    };
  };
}