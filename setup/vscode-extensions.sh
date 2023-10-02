#!/bin/sh

. $(dirname $0)/../commons.sh


main() {
  h1 "Installing useful vscode extensions"
  code --install-extension dbaeumer.vscode-eslint
  code --install-extension EditorConfig.EditorConfig
  code --install-extension ms-azuretools.vscode-docker
  code --install-extension patbenatar.advanced-new-file
  code --install-extension PKief.material-icon-theme
  code --install-extension RoscoP.ActiveFileInStatusBar
  code --install-extension vscodevim.vim
  code --install-extension foxundermoon.shell-format
  code --install-extension yzhang.markdown-all-in-one
  code --install-extension ms-vsliveshare.vsliveshare

  green_tick "Installed vscode extensions"
}

main
