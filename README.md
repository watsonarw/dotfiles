# dotfiles

The most over-engineered shell scripts I've ever written, AKA scripts for setting up a new machine

## Setting up a new machine

Note: This has only been built to work on MacOS, I might add other platforms when I need them

```sh
xcode-select --install && \
git clone https://github.com/watsonarw/dotfiles.git ~/.dotfiles && \
cd ~/.dotfiles
```

Then run:
```
./setup.sh
```

## What this sets up

* [brew]
* [mise]
* Up to date versions of some "core" utilities
* Git config
* [oh my zsh](https://ohmyz.sh/)
* MacOS dark mode, menu bar, keyboard and some other UX preferences
* [Visual Studio Code](https://code.visualstudio.com/), default plugins and settings
* A bunch of tools and MacOS apps that I use all the time
* More stuff

## How it works

* A bunch of shell scripts
* Modules which can be enabled/disabled for each install
* It should be idempotent (I hope), and safe to run multiple time

## Adding a new module

1. Make a copy of (modules/.template/) with an appropriate module name
   * Prepend the module name with `local` or `private` for things that shouldn't be committed
2. Remove unnecessary files
   * (e.g. if the module only needs to install things with Brew, only keep `.Brewfile`)
3. Run `./setup.sh` to set up the new module

[mise]: https://mise.jdx.dev/
[brew]: https://brew.sh/
