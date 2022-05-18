# Noteable

A prototype workflow shell for your notes.

TODO: screenshot, link to asciinema

## Install

1. install nix
2. add `experimental-features = nix-command flakes` to your nix config ([quick intro to flakes](https://zimbatm.com/notes/nixflakes))
3. install: `nix profile install github:aquiferma/noteable`
4: run: `noteable`

Note: To use the bundled binary cache, you will need to be listed in your nix.conf `trusted-users` or have nix running in single user mode. 

## Using 

The menu should be self-documenting. If you want to run something that's not in the menu, press \` for a shell.

## Roadmap

- [ ] Capture/edit (NeoVIM)
- [ ] Preview/Browse (emanote)
- [ ] Search (telescope)
- [ ] Filter (facets)
- [ ] Push
- [ ] Review (linter, PR mod queue)

### Publishing

- Script to sync a list of files/directories to another branch
- Confirm added/removed/changed files or abort
- Config file

```yaml
publications:
  - branch: techblog
    selectors:
      - /tech
    confirm: true
```

- Menu to install/check git hook

### Service mgmt

 - supervisor (runit I think)
 - Need an `openport` script https://unix.stackexchange.com/questions/55913/whats-the-easiest-way-to-find-an-unused-local-port

### editor
- [ ] `e` launch nvim
  - [ ] launch nvim server on first run
- [ ] Customize neovim config using https://github.com/syberant/nix-neovim/
  - [ ] Add telescope, and a binding
- [ ] Shortcut to traverse wikilinks (ref https://github.com/srid/emanote/discussions/237#discussioncomment-2024104)
- [ ] `, b` Backlinks (ask Emanote show, with Telescope)

### modes

- [ ] `\` "global leader menu" (I think) [which-key](https://github.com/folke/which-key.nvim) not [nvim-libmodal](https://github.com/Iron-E/nvim-libmodal) but maybe both?
- [ ] `\ /` find notes (telescope, basic)

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


## nvim research

Needed packages
 - git ui: neogit (magit clone) or lazygit
 - https://github.com/pta2002/nixvim/issues/16