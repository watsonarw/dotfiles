# dotfiles

The most over-engineered shell scripts I've ever written, AKA dotfiles for setting up a machine

## Usage

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
* Up to date versions of some "core" utilities
  * See [Brewfile](./modules/0.core/Brewfile) to find out which
* A bunch of MacOS apps that I use all the time
  * Via [Brew cask](https://github.com/Homebrew/homebrew-cask) and [Brew bundle](https://github.com/Homebrew/homebrew-bundle)

* [mise] for managing tool versions/SDKs
* [pkgx] for running packages that aren't installed
* 1password SSH agent
* Git config
* [oh my zsh](https://ohmyz.sh/)
* MacOS dark mode, menu bar, keyboard and some other UX preferences
* [Visual Studio Code](https://code.visualstudio.com/), default plugins and settings
* More stuff

## How it works

* A bunch of shell scripts
* [brew], [mise] and [pkgx]


## [brew]. [mise], or [pkgx] - When to use each?

- MacOS apps are installed with [brew] cask
- "Core" packages, particularly if they're part of the shell (e.g. zsh, git coreutils) installed via [brew]
- SDKs, tool versions etc, particularly those specific to a project should be installed with [mise]
- Packages/tools that are run to acheive a specific task (e.g. jq, tree, docker) via [pkgx]

[mise]: https://mise.jdx.dev/
[pkgx]: https://pkgx.sh/
[brew]: https://brew.sh/
