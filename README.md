# notesflow

Activity flows for your notes

- [ ] Capture/edit (NeoVIM)
- [ ] Preview/Browse (emanote)
- [ ] Search (telescope)
- [ ] Filter (facets)
- [ ] Push
- [ ] Review (linter, PR mod queue)

Note the empty boxes above. This is WIP POC software. Help me fill those boxes!

## Install
### With nix
#### Preconditions

- nix 2.5 or newer with `experimental-features = nix-command flakes`. See https://zimbatm.com/notes/nixflakes
- To automatically use bundled binary cache:
  - nix `2.7.1` (unreleased) or newer for [`nix run` support](https://github.com/NixOS/nix/issues/6170)
  - Be listed in nix.conf `trusted-users` or nix running in single user mode.

#### Try

`nix run github:flakeflows/notesflow`

#### Install

`nix profile install github:flakeflows/notesflow`

### As a bundle

TODO

## Usage

From your notes directory:

```
notesdir
```

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
- [ ] Figure out how to configure neovim without NixOS/Home-manager modules
  - Crib from https://github.com/nix-community/neovim-nightly-overlay/pull/112/files
  - https://github.com/jordanisaacs/neovim-flake
- [ ] `e` launch nvim
  - [ ] launch nvim server on first run
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

- [ ] `b` branches
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
    - Feed emanote into baloo?

    -  https://github.com/mickael-menu/zk as facetting backend? Not sure it's adding beyond emanote, but worth testing.

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

Candidates:

### Ideas

- Expose neovimConfig
- Expose desktop files for terminal, browser
- Call xdg-run et al



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
  - [ ] home manager module
  - [ ] expose constructor as flake API
- [ ] First party build cache
  - [ ] CI builds
  - [ ] Cache builds
  - [ ] Add to flake
 [ ] linux VM for linuxey stuff
  - https://github.com/nix-community/nixos-generators (vm subcommand)
  - https://github.com/lima-vm/lima
  - Accelerated access to host FS? Esp inotify for baloo etc.
    - https://github.com/lima-vm/lima/issues/20#issuecomment-845781236
    - https://docs.docker.com/desktop/mac/release-notes/#docker-desktop-460