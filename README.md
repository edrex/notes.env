A small software environment for working with a directory of text-based notes.

## Design criteria

- Context is current directory
- Minimal dependencies on environment
- Single entry point makes all (most) functionality discoverable
- Linters to ensure wanted data invariants

## Implicit assumptions

- For now, I'm assuming this will be run on a directory containing markdown files, with various extensions optionally supported. Later, I would like to loosen this assumption to work with any files present (org, media, etc) and use the linters to help users shephard their wikis into the shape they want.



## Install
### With nix
#### Preconditions

- nix
- 

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
- [x] (s)erve (emanote)
- [ ] (\`) shell


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

Much of what I want to test out is covered at https://zimbatm.com/notes/nixflakes.

- [x] nix run (runnable)
- [x] installable
- [ ] first party binary cache
  - [ ] CI to populate
  - [ ] Include with flake https://github.com/NixOS/nix/issues/5507
- [ ] how to run the shell via direnv
- [ ] manage background services from menu
- [ ] home manager
- [ ] An example flake for bundling this with your own wiki ?

