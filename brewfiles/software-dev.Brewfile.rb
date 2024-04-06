cask "bruno"

brew "colima"
brew "docker"
brew "docker-compose"

tap "homebrew/cask-fonts"
brew "svn"
cask "font-fira-code"
cask "font-hack"

brew "mas"
mas "XCode", id: 497799835

##### VS Code + Plugins
cask "visual-studio-code"

# Base plugins
vscode "editorconfig.editorconfig"
vscode "mikestead.dotenv"
vscode "ms-vsliveshare.vsliveshare"
vscode "pkief.material-icon-theme"
vscode "eamodio.gitlens"

# File utils
vscode "patbenatar.advanced-new-file"
vscode "sleistner.vscode-fileutils"
vscode "roscop.activefileinstatusbar"

# Markdown utils
vscode "bierner.markdown-mermaid"
vscode "bierner.markdown-preview-github-styles"
vscode "bpruitt-goddard.mermaid-markdown-syntax-highlighting"
vscode "yzhang.markdown-all-in-one"

# Converters
vscode "adamhartford.vscode-base64"
vscode "espresso3389.unixtime-converter"

# Languages / Filetypes
vscode "ms-azuretools.vscode-docker"
vscode "dbaeumer.vscode-eslint"
vscode "foxundermoon.shell-format"
vscode "jock.svg"
vscode "mechatroner.rainbow-csv"
