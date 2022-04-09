# notesdir

A small software environment for your plain-text notes directory.

## Design

### Criteria

- Context is current directory
- Self-contained, minimal dependencies on environment
- Discoverability of all (most) functionality via a single entry point (menu).
- Linters to ensure wanted data invariants

### Implicit assumptions

- For now, I'm assuming this will be run on a directory containing markdown files, with various extensions optionally supported. Later, I would like to loosen this assumption to work with any files present (org, media, etc) and use the linters to help users shephard their wikis into the shape they want.

### Open questions

Support multiple entry points:

 - Menu
 - Env Shell
 - One-off command

Maybe one exe with `-s` and `-c` flags? Tydra needs a flag to run a command on a page.

## Install
### With nix
#### Preconditions

- nix 2.5 or newer with `experimental-features = nix-command flakes`. See https://zimbatm.com/notes/nixflakes
- To automatically use bundled binary cache:
  - nix `2.7.1` (unreleased) or newer for [`nix run` support](https://github.com/NixOS/nix/issues/6170)
  - Be listed in nix.conf `trusted-users` or nix running in single user mode.

#### Try

`nix run github:edrex/notesdir`

#### Install

`nix profile install github:edrex/notesdir`

### As a bundle

TODO

## Usage

From your notes directory:

```
notesdir
```

The menu should be self-documenting. If you want to run something that's not in the menu, press \` for a shell.


## Milestones

### M0

- [x] tydra menu
   - [x] shell script to run
   - [x] gen menu from nix attrset via toYAML https://github.com/NixOS/nixpkgs/blob/master/lib/generators.nix
- [x] launch background service on startup (tmux) first pass
- [ ] (\`) shell (requires refactoring derivation)

### M1

- [ ] (g)en
- [ ] (/) search (fzf?) 

### Feature ideas

## Functions

- [ ] https://github.com/mickael-menu/zk (menu)
- [ ] neovim config
- toggles
- watcher (commit, push, etc)
- Bundle a self-contained editor + config (neovim or evil emacs) (but also bring your own editor via env vars)

## Proving out technology

### Flakes

See https://zimbatm.com/notes/nixflakes for a concise intro to some of the important parts.

- [x] nix run (runnable)
- [x] installable
- [ ] shell
  - [x] launch from menu
  - [ ] set prompt to indicate status (starship or sim?)
- [ ] how to run the shell via direnv
- [ ] home manager
- [ ] An example flake for bundling this with your own wiki ?
- [ ] first party binary cache
  - [ ] CI to populate
  - [ ] Include with flake https://github.com/NixOS/nix/issues/5507

### Mux

- [x] auto launch dir-scoped singleton service manager with services on startup
- [ ] Multi-pane env (ala emacs minibuffer etc) via tmux
- [ ] show service+manager statuses (in menu, or maybe in a status line? emoji?)
  - [ ] manage services from menu (stop, start, show)

### Process

- Feature branches / PRs for first party changes
- Changelog workflow