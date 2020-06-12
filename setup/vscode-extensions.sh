#!/bin/sh

. $(dirname $0)/../commons.sh


main() {
  h2 "Installing useful vscode extensions"
  code --install-extension dbaeumer.vscode-eslint
  code --install-extension EditorConfig.EditorConfig
  code --install-extension ms-azuretools.vscode-docker
  code --install-extension patbenatar.advanced-new-file
  code --install-extension PKief.material-icon-theme
  code --install-extension RoscoP.ActiveFileInStatusBar
  code --install-extension vscodevim.vim
  code --install-extension foxundermoon.shell-format
  code --install-extension CoenraadS.bracket-pair-colorizer
  code --install-extension yzhang.markdown-all-in-one

  green_tick "Installed vscode extensions"
}

main
