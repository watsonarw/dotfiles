# dotfiles

The most over-engineered shell scripts I've ever written, AKA scripts for
setting up a new machine.

## Setting up a new machine

Note: This has only been tested on MacOS, parts might work on other platforms,
but I'll fix that when I need to.

Install xcode tools first

```sh
xcode-select --install
```

Clone the repo

```sh
git clone https://github.com/watsonarw/dotfiles.git ~/.dotfiles && \
cd ~/.dotfiles
```

Run:

```
./setup.sh
```

## How the module system works

Each directory under `modules/` is a module. On first run, `setup.sh` prompts
you to select which modules to enable. The selection can be persisted for
subsequent runs.

### Execution

1. `./setup.sh` finds and runs all `*.sh` files across enabled modules and
   executes them
2. Enabled modules are processed _alphabetically_, then files within a module
   _alphabetically_. Most of the time order isn't important, as modules are self
   contained, but that's not always the case.
3. Number-prefixed modules (`0.brew`, `0.core`) run before everything else

### Aggregators

Some modules scan enabled modules for specific file patterns:

| Module                  | Scans for                  | Effect                                                      |
| ----------------------- | -------------------------- | ----------------------------------------------------------- |
| `0.brew/setup.sh`       | `*.Brewfile`               | Builds a global Brewfile and runs `brew bundle`             |
| `0.core/mise.setup.sh`  | `mise.toml`, `*.mise.toml` | Links configs into mise's `conf.d/` and runs `mise install` |
| `0.core/xdg.setup.sh`   | `.config/*`                | Symlinks into `~/.config/`                                  |
| `0.core/zshrc.setup.sh` | `*.zshrc`                  | Aggregates into `~/.zshrc`                                  |

This means a module doesn't need a `setup.sh` to be useful, just drop a
`.Brewfile`, `mise.toml`, `.zshrc`, or `.config/` directory and the aggregators
will pick it up.

## Module taxonomy

| Prefix       | Purpose                                   | Examples                                 |
| ------------ | ----------------------------------------- | ---------------------------------------- |
| `0.*`        | Core infrastructure (must run first)      | `0.brew`, `0.core`                       |
| `dev`        | Base development tools (VSCode, settings) | `dev`                                    |
| `dev.*`      | Opt-in dev toolchains/languages           | `dev.docker`, `dev.react`, `dev.deno`    |
| `software.*` | Standalone GUI applications               | `software.1password`, `software.firefox` |

## Adding a new module

1. Copy `modules/.template/` with an appropriate name following the taxonomy
   above
   - Append or prepend with `local` or `private` for things that are machine
     specific and shouldn't be committed
2. Remove unnecessary files — most modules only need one or two of the available
   file types
3. Run `./setup.sh` and enable the new module

## File conventions

| File pattern                | Purpose                                                                  |
| --------------------------- | ------------------------------------------------------------------------ |
| `setup.sh` / `*.setup.sh`   | Executable setup scripts (run in order)                                  |
| `.Brewfile` / `*.Brewfile`  | [Homebrew] dependencies (picked up by `0.brew`)                          |
| `mise.toml` / `*.mise.toml` | [mise] tool versions and tasks (picked up by `0.core`)                   |
| `.zshrc` / `*.zshrc`        | Shell config sourced into `~/.zshrc` (picked up by `0.core`)             |
| `.config/*/`                | XDG config directories symlinked to `~/.config/` (picked up by `0.core`) |

[mise]: https://mise.jdx.dev/
[Homebrew]: https://brew.sh/
