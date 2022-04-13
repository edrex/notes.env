# notesflow

A **portable**, **minimal**, **sufficient**, and **discoverable** flow for your **notes**.

- [ ] NeoVIM-based 
- [ ] Search full-text * metadata facets
- [ ] Fix nits ("Must have a title", "No dangling links") via an interactive linter system
- [ ] Commit local changes
- [ ] Manage draft branches
- [ ] Review incoming change requests

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

### v0.0.1 poc

- [x] tydra menu
   - [x] shell script to run
   - [x] gen menu from nix attrset via toYAML https://github.com/NixOS/nixpkgs/blob/master/lib/generators.nix
- [x] `` ` `` shell (requires refactoring derivation)
- [x] `p` preview (links)

### v0.0.2 nvim
- [ ] `e` launch nvim
  - [ ] launch nvim server on first run
- [ ] `SPC` "leader menu" (using https://github.com/Iron-E/nvim-libmodal/blob/master/doc/libmodal.txt)
- [ ] `SPC /` find notes (telescope, basic)

### v0.0.3 neomux
- [ ] port POC to nvim
  - [ ] launch emanote background service on first run (managed by nvim server)
    - [ ] `SPC s d` clean up env services
  - [ ] ``SPC ` `` terminal (below)
  - [ ] Neomux shortcuts/modes (TODO)

### v0.0.4 WikiLinks
- [ ] Evaluate existing implementations (ref https://github.com/srid/emanote/discussions/237#discussioncomment-2024104)
- [ ] Shortcut to traverse wikilinks
- [ ] `, b` Backlinks (ask Emanote show, with Telescope)

## Planned

### Epic: Branches

- [ ] `b` branches
  - [ ] `b` open a new draft branch
  - [ ] `/` search branches
  - [ ] `r` review change requests (`gh pr list`)

### Epic: Facetted Search
- [ ] `SPC f` Facetted search (via `emanote metadata`)
  - [ ] Search for suitable existing filter UI implementation
  - [ ] Eval https://github.com/mickael-menu/zk as facetting backends. Both or just Emanote?
  - [ ] `/` push mode stack to telescope (`ESC` returns to facets)
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

## Flake.. Flows?

This project is a technology demonstration for a new method of composing reproducible, portable software environments using [nix flakes](https://zimbatm.com/notes/nixflakes).

Expect parts to be factored out into a helper flake for constructing other flows.

### Design Principles

- Isolated environment
- Batteries Included 
- Self-contained, minimal dependencies on environment
- Discoverability of all (most) functionality via a single entry point (menu).

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
- [ ] first party binary cache
  - [ ] CI to populate
  - [ ] Include with flake https://github.com/NixOS/nix/issues/5507