# notes.env
### A portable native software environment for digitized and networked thought, AKA

- Personal wiki
- Zettelkasten
- Second Brain
- Digital Garden
- ... etc

## Who is this for?

To enjoy this ride, you should be at least begrudgingly willing to open a terminal session and copy a few commands.

It's for people who have or want to create on-device sync'd note repositories in a nice integrated environment. If you just want to put your notes in the cloud, maybe check out [Roam Research](https://roamresearch.com/).

## Principles

### Adaptable

- Ala carte: use the parts that make sense for you
- Platform-native experiences (mobile/desktop apps, browser extensions, OS hooks etc)
- Work with existing data in a careful, helpful way.
  - LINT LINT LINT LINT LINT
  - Refuse to take actions which mutate unless certain lints pass
  - Provide automated / interactive refactors to resolve lints.

### Discoverable

 - Capabilities, via contextual menus and help
 - Data, via index-driven views (search, facet browse, related records for current document)

### Autonomous

- Local-first, work offline
- Easy to fork/use as a library if you want to do your own thing

## Interconnected

- Opportunistic data sync
- Integrate existing metadata sources
  - local: browser history, shell
  - network: petname-based InterWiki links

## Prerequisites

You'll need:

- a willingness to type commands into a console, for 
- a laptop- or android device- haver (no iOS support at present, but watch this space)
- [Nix Flakes](https://zimbatm.com/notes/nixflakes) installed
 - Mac, Linux: https://github.com/mschwaig/howto-install-nix-with-flake-support
 - Android: [nix-on-droid](https://github.com/t184256/nix-on-droid) (select "yes" when it asks if you want flake support)
 -  Windows 10+: Run under WSL, following Linux instructions. If you want a full NixOS install under WSL2, see [NixOS-WSL](https://github.com/nix-community/NixOS-WSL)

WARNING: 

### WARNING: Footguns

:facepalm:

Nix is full of [footguns](https://www.urbandictionary.com/define.php?term=footgun). If you get stuck trying to follow these instructions, open an issue here and I will help you get unstuck, and then we can improve documentation or fix things upstream.

Please don't take my use of Nix in Notes.env as a recommendation that you learn the Nix language. It has a brutal learning curve, and it will likely be several years before you know enough to be productive.

I do however recommend that you learn the basics of Nix the package manager, because it will give you super-powers. The ONLY subcommands you need are:

 - [`nix run`](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-run.html)
 - [`nix shell`]()
 - [`nix profile install/remove/upgrade`](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-profile-install.html) (but `remove` and `upgrade` have a footgun, see [nix#7960](https://github.com/NixOS/nix/issues/7960)).

Eventually, Notes.env will provide platform-native builds (Android app, container image etc) which don't require Nix (milestone: grandparent-ready).

## Ways to use this

### Run without installing

```
cd ~/my_markdown_notes_dir
nix run github:edrex/notes.env
```

After a some network IO, the Notes.env top level menu will present. Entry descriptions should provide sufficient documentation (submit a PR if you see ways to improve inline docs).

If you want to run something that's not in the menu, press \` for a shell.

### Install into your home environment

TODO

`nix profile install github:edrex/notes.env`

This will add the menu and all bundled packages to your user environment.
`notesdir`

### Using your own flake.nix

TODO

## Next actions

- [ ] update emanote and other inputs to latest, update cache URLs, etc
- add default package that pulls in all packages
- add packages.logseq
- home-manager module
  - chrome extensions via `cfg.chromiumIntegration.enable = true` defaults to value of `config.programs.chromium.enable`
    - [deathau/markdownload: A Firefox and Google Chrome extension to clip websites and download them into a readable markdown file.](https://github.com/deathau/markdownload)

## Next + 1

### term tools for wiki / research

In this iteration I want to build out the story for a console-based editor using 
[Helix Editor](https://helix-editor.com/), and using console mode programs as backing primatives,
which has the advantage of decoupling logic from the environment (ie helix, neovim, fish, etc).

- [ ] `(gn)|(gp) $FILENAME` (returns next/previous entry)
- [ ] figure out how to map above in helix
  - cmd expansions branch takes care of input param
  - how to tell helix to open returned path?
  - what about macro mapping?
- [ ] `d` update
- [ ] ` fix (`e -> $VISUAL`)
- [ ] `new e cmd with logic to check diff vars/env and fetch hx if nothing is set, then exec`

## Future

- investigate android specialization
  - nix-on-droid module to install apps etc via activation script?
    - logseq
    - markor
- Declarative petname-based InterWiki namespace registry (`[[goog:"search terms"]]`, `[[nixpkgs:foo]]` etc)
- Experimental support for [noosphere](https://github.com/subconsciousnetwork/noosphere).

- BuJo actions
  - Refile
  - Archive done (move to bottom of journal file?)
  - Bring yesterday item forward to today (keep + mark old entry, copy foward)
  - Consider use orgmode again for tasks? Seems logseq at least supports it. Or is that stupid? Not sure. A gamble of time, for sure.



**Below this line is out of date and needs editing.**
  
-----

  
  - Bind user's existing agents (devices, browsers, shells, editors, etc) into a trusted personal network sharing 
  - Agents form a bootstrapped p2p network

environment, be it a hw node, terminal, gui shell, web app, editor, browser extension, etc.
  - Form a trusted network of user agents to sharing context via a common metadata layer. 
Understand user context
  - (eg visited dirs/URLs/geo/workspace, command history)
  - across agents (browser, phone, shell, editor)


## Design goals

 - Environment scoping by dir, location, project, tag, etc.
- Deliver functionality to both text editor and shell (kakoune makes this easy hmm)

## M1 Tasks
- Examples to consume environment:
  - [ ] menu via `nix run`
  - [ ] env via `nix develop`
  - [ ] either via .envrc / nix-direnv
  - [ ] as a pkg exposing all bins, in your flake
  - [ ] as an app exposing only main script, `notes.env`
- Editor:
  - [ ] Try out kakoune, comparing to helix which I am currently using
    - Better shell integration for ranger file picker, fzf, etc
    - It's a server!
    - No LSP out of box, but [kak-lsp](https://github.com/kak-lsp/kak-lsp) looks good.
    - Nix support?
  - [ ] kak-lsp, marksman for following markdown wiki links.

## MVP+1 Tasks
- [ ] Eval kak as alternative default editor
    - PRO: better shell integration would allow reusing tools such as ranger
Settled on Helix for out of box functionality (LSP, file search)


### Introspection

Navigation and linting via LSP in editor ([mickael-menu/zk](https://github.com/mickael-menu/zk) and marksman)
- [ ] Preview/Browse (emanote)
- [ ] Search (telescope)
- [ ] Filter (facets)
- [ ] Push
- [ ] Review (linter, PR mod queue)

Note the empty boxes above. This is WIP POC software. Help me fill those boxes!

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


## nvim research

Needed packages
 - git ui: neogit (magit clone) or lazygit
 - https://github.com/pta2002/nixvim/issues/16