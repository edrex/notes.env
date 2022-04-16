# notesflow

Activity flows for your notes

- [ ] Capture/edit (NeoVIM)
- [ ] Preview/Browse (emanote)
- [ ] Search (telescope)
- [ ] Filter (facets)
- [ ] Push
- [ ] Review (linter, PR mod queue)

Note the empty boxes above. This is WIP POC software. Help me fill those boxes!

## Quick Start

1. install nix 2.5 or newer
2. add `experimental-features = nix-command flakes` to your nix config ([quick intro to flakes](https://zimbatm.com/notes/nixflakes))
3. install: `nix profile install github:flakeflows/notesflow`
4: run: `notesdir`

Note: To use the bundled binary cache, you will need to be listed in your nix.conf `trusted-users` or have nix running in single user mode. Until nix 2.7.1 is released avoid `run` since it [doesn't use the cache](https://github.com/NixOS/nix/issues/6170)

The menu should be self-documenting. If you want to run something that's not in the menu, press \` for a shell.

## Roadmap

### v0.0.0 menu

- [x] tydra menu
   - [x] shell script to run
   - [x] gen menu from nix attrset via toYAML https://github.com/NixOS/nixpkgs/blob/master/lib/generators.nix

### v0.0.1 shell
- [x] `` ` `` shell (refactor derivation)
- [x] start persistent env service manager (tmux instance) on first run
  - [x] start emanote in tmux
  - [ ] if tmux exits with a bad status, display error
  - [ ] if emanote errs, display log
- [x] `s` tmux attach (later this will be the services menu)
- [x] `q` clean up background services and exit

### v0.0.2 editor
- [ ] `e` launch nvim
  - [ ] launch nvim server on first run
- [ ] Customize neovim config using https://github.com/syberant/nix-neovim/
  - [ ] Add telescope, and a binding
- [ ] Shortcut to traverse wikilinks (ref https://github.com/srid/emanote/discussions/237#discussioncomment-2024104)
- [ ] `, b` Backlinks (ask Emanote show, with Telescope)

### v0.0.3 modes

See [](docs/v0.0.3.md)
- [ ] `\` "global leader menu" (I think) [which-key](https://github.com/folke/which-key.nvim) not [nvim-libmodal](https://github.com/Iron-E/nvim-libmodal) but maybe both?
- [ ] `\ /` find notes (telescope, basic)

## Planned

### linter
- [ ] Interface: https://pre-commit.com/
- [ ] Manage local repo hooks interactively
- [ ] Emanote checks
- [ ] Interactive resolvers?

### version control

- [ ] `b` branchesConfigurations
  - [ ] `b` open a new draft branch
  - [ ] `/` search branches
  - [ ] `r` review change requests (`gh pr list`)

### facetted search

- [ ] `\ f` Facetted search
  - [ ] Implementations research:
    - emanote query (proposed) or `curl ${emanote_service}/-/export.json | jq ...` 
    - facetted desktop search engine: (TODO: figure out persistent / cache dirs for index etc )
      - https://www.lesbonscomptes.com/recoll/
        - TODO: build on mac https://framagit.org/medoc92/recoll/-/blob/master/packaging/mac/make-recoll-dmg.sh
        - https://www.lesbonscomptes.com/recoll/usermanual/webhelp/docs/RCL.SEARCH.COMMANDLINE.html
    - Feed emanote export into recoll?
    - https://github.com/mickael-menu/zk as facetting backend? Not sure it's adding beyond emanote, but worth testing.
  - [ ] `/` push telescope onto mode stack (`ESC` returns to facets)
    - [ ] `a` All notes (reset filters)
    - [ ] `s` Statuses
      - [ ] `w` Working copy `git status`
      - [ ] `p` Published
    - [ ] Tags
    - [ ] By Type
      - [ ] Markdown
      - [ ] Ledger (https://www.ledger-cli.org/)
      - [ ] Images
      - [ ] Videos
      - [ ] Audio
      - [ ] Templates
      - [ ] Metadata

### Composable

This means:
- Expose internal implementations so they can be used externally
  - neovimConfig
  - tydra menus
  - desktop files for for builtin terminal, browser implementations
  - library functions (extract where reuseful)
- Allow the injection of dependencies (bring your own terminal launcher etc)
  - At build-time, via the nix constructors
  - At run-time, via ENV vars
    - Maybe call xdg-run et al (this could be one build-time implementation of an "opener")

### Ideas

- A utility function that does build-time evaluation or lazy runtime evaluation depending on a global flag. This would allow the whole system to be built lazy.

## Flake.. Flows?

[notesflow](https://github.com/flakeflows/notesflow) is a technology demonstration for a new method of composing interactive software environments, using [nix flakes](https://zimbatm.com/notes/nixflakes).

Utility functions will be factored out into a flakeflow library, along with this section of the README.

### Design Principles

- Reliable:
  - Depend minimally on the environment, and only in well-defined ways (`ENV`, `PWD`)
  - Adapt to the runtime: do the right thing on Linux, Docker, OSX, Android etc
  - Provide comprehensible feedback on bad input.
- Ergonomic:
  - Efficiently flow through a network of related task modes.
  - Discover all flows via root mode.
- Composable, so you can sample [like Rza](https://www.youtube.com/watch?v=jSEs8-46Qlo)).

### Technology demonstrations

- [x] nix run (runnable)
- [x] installable
- [x] srid cache
- [ ] ENV-based configuration
  - [ ] Load `.env` in bootstrap script
  - [ ] `BROWSER=`
  - [ ] `CONTENT_VALIDATORS=` or something
- [ ] Usable as a library in your own flake
  - [ ] expose constructor as flake API
  - [ ] home manager module for registering services etc
- [ ] First party build cache
  - [ ] CI builds
  - [ ] Cache builds
  - [ ] Add to flake
 [ ] linux VM for linuxey stuff? Is this crazy pants?
  - https://github.com/nix-community/nixos-generators (vm subcommand)
  - https://github.com/lima-vm/lima
  - Accelerated access to host FS? Esp inotify for baloo etc.
    - https://github.com/lima-vm/lima/issues/20#issuecomment-845781236
    - https://docs.docker.com/desktop/mac/release-notes/#docker-desktop-460
    - https://github.com/containers/krunvm looks like a winner