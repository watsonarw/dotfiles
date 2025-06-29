#!/usr/bin/env bash

. "$(dirname "$0")/../../lib/load.sh"

# Sets reasonable macOS defaults.
#
# Some settings grabbed from:
#   https://github.com/albertoqa/dotfiles/blob/master/bin/macos.sh
#

###############################################################################
# General                                                                     #
###############################################################################
set_dark_mode() {
  defaults write ~/Library/Preferences/.GlobalPreferences.plist AppleInterfaceTheme -string "Dark"
  defaults write ~/Library/Preferences/.GlobalPreferences.plist AppleInterfaceStyle -string "Dark"
  osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
}

macos_general_setup() {
  set_dark_mode

  echo "Show Battery Percentage on the menu bar"
  defaults -currentHost write com.apple.controlcenter Battery -int 2
  defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

  echo "Disable auto-correct spelling automatically"
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

  echo "Show seconds and 24h time in menu bar"
  defaults write NSGlobalDomain AppleICUForce24HourTime -bool true
  defaults write com.apple.menuextra.clock ShowSeconds -bool true

  echo "Show bluetooth status in menubar"
  defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true

  echo "Use AirDrop over every interface."
  defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1
}

###############################################################################
# Finder                                                                      #
###############################################################################
macos_finder_setup() {
  echo "Always open everything in Finder's list view. This is important."
  defaults write com.apple.Finder FXPreferredViewStyle Nlsv

  echo "Show the ~/Library folder."
  chflags nohidden ~/Library

  echo "Set User home as the default location for new Finder windows"
  defaults write com.apple.finder NewWindowTarget -string "PfHm"
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

  echo "Show all filename extensions"
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
}

###############################################################################
# Keyboard                                                                    #
###############################################################################
macos_keyboard_setup() {
  echo "Set a fast keyboard repeat rate"
  defaults write NSGlobalDomain KeyRepeat -int 2
  defaults write NSGlobalDomain InitialKeyRepeat -int 20

  echo "Disable press-and-hold for keys in favor of key repeat"
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

  echo "Use Function keys as Function keys"
  defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

  echo "Enable Use keyboard navigation to move focus between controls"
  defaults write -g AppleKeyboardUIMode -int 2
}

###############################################################################
# Dock                                                                     #
###############################################################################
macos_dock_setup() {
  echo "Automatically hide and show the Dock"
  defaults write com.apple.dock autohide -bool true

  echo "remove all icons from the dock"
  defaults write com.apple.dock persistent-apps -array
  defaults write com.apple.dock show-recents -bool false

  echo "Set the Finder prefs for showing a few different volumes on the Desktop."
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
}

###############################################################################
# Security & Privacy                                                          #
###############################################################################

macos_privacy_setup() {
  echo "Require password immediately after sleep or screen saver begins"
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0
}

###############################################################################
# Trackpad                       	                                      #
###############################################################################

macos_trackpad_setup() {
  echo "enable tap to click for this user and for the login screen"
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
}

setup_defaults() {
  h2 "Setting up MacOS defaults"

  macos_general_setup
  macos_finder_setup
  macos_keyboard_setup
  macos_dock_setup
  macos_privacy_setup
  macos_trackpad_setup

  killall Dock
  killall SystemUIServer
  killall Finder

  style bold yellow "Note that some of these changes require a logout/restart to take effect."
}

main() {
  h1 "Setting up ${script_dir}"

  setup_defaults

  green_tick "Done"
}

main
