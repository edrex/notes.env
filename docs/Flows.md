## Flake.. Flows?

This is a technology demonstration for a new method of composing interactive software environments, using [nix flakes](https://zimbatm.com/notes/nixflakes).

Utility functions will be factored out into a flakeflow library, along with this section of the README.

### Design Principles

- Reliable:
  - Depend minimally on the environment, and only in well-defined ways (`ENV`, `PWD`)
  - Adapt to the runtime: do the right thing on Linux, Docker, OSX, Android etc
- Ergonomic:
  - Efficiently flow through a network of related task modes.
  - Discover all flows via root mode.
- Modular, so you can sample [like Rza](https://www.youtube.com/watch?v=jSEs8-46Qlo)).
  - Customize modules by passing input parameters at build time
    - neovimConfig
    - tydra menus
    - default terminal, web browser
  - Use modules ala-carte,imConfig layer.
    - library functions (extract where reuseful)
  - Inject dependencies (bring your own terminal launcher etc)
    - At build-time, via the nix constructors
    - At run-time, via ENV vars
      - Maybe call xdg-run et al (this could be one build-time implementation of an "opener")

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
- [ ] helper function to optionally evaluate some parts (eg, vim) lazily, at run-time (depending on a build-time option)
- [ ] Portable VM for linuxey stuff (systemd, wayland)? Maybe gbetter to try to be native.
  - https://github.com/nix-community/nixos-generators (vm subcommand)
  - https://github.com/lima-vm/lima
  - Accelerated access to host FS? Esp inotify for baloo etc.
    - https://github.com/lima-vm/lima/issues/20#issuecomment-845781236
    - https://docs.docker.com/desktop/mac/release-notes/#docker-desktop-460
    - https://github.com/containers/krunvm looks like a winner