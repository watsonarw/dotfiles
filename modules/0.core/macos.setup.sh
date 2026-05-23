#!/usr/bin/env bash
set -euo pipefail

script_dir=$(dirname "$0")
lib_dir="$script_dir/../../lib"
. "$lib_dir/lib-loader.sh"
load_libs "$lib_dir"

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

  style dim "Show Battery Percentage on the menu bar"
  defaults -currentHost write com.apple.controlcenter Battery -int 2
  defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

  style dim "Disable auto-correct spelling automatically"
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

  style dim "Show seconds and 24h time in menu bar"
  defaults write NSGlobalDomain AppleICUForce24HourTime -bool true
  defaults write com.apple.menuextra.clock ShowSeconds -bool true

  style dim "Show bluetooth status in menubar"
  defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true

  style dim "Use AirDrop over every interface."
  defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1
}

###############################################################################
# Finder                                                                      #
###############################################################################
macos_finder_setup() {
  style dim "Always open everything in Finder's list view. This is important."
  defaults write com.apple.Finder FXPreferredViewStyle Nlsv

  style dim "Show the ~/Library folder."
  chflags nohidden ~/Library

  style dim "Set User home as the default location for new Finder windows"
  defaults write com.apple.finder NewWindowTarget -string "PfHm"
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

  style dim "Show all filename extensions"
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
}

###############################################################################
# Keyboard                                                                    #
###############################################################################
macos_keyboard_setup() {
  style dim "Set a fast keyboard repeat rate"
  defaults write NSGlobalDomain KeyRepeat -int 2
  defaults write NSGlobalDomain InitialKeyRepeat -int 20

  style dim "Disable press-and-hold for keys in favor of key repeat"
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

  style dim "Use Function keys as Function keys"
  defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

  style dim "Enable Use keyboard navigation to move focus between controls"
  defaults write -g AppleKeyboardUIMode -int 2
}

###############################################################################
# Dock                                                                     #
###############################################################################
macos_dock_setup() {
  style dim "Automatically hide and show the Dock"
  defaults write com.apple.dock autohide -bool true

  style dim "Remove all icons from the dock"
  defaults write com.apple.dock persistent-apps -array
  defaults write com.apple.dock show-recents -bool false

  style dim "Set the Finder prefs for showing a few different volumes on the Desktop."
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
}

###############################################################################
# Security & Privacy                                                          #
###############################################################################

macos_privacy_setup() {
  style dim "Require password immediately after sleep or screen saver begins"
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0
}

###############################################################################
# Trackpad                       	                                      #
###############################################################################

macos_trackpad_setup() {
  style dim "Enable tap to click for this user and for the login screen"
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
}

setup_defaults() {
  style bold "Setting up macOS defaults"

  macos_general_setup
  macos_finder_setup
  macos_keyboard_setup
  macos_dock_setup
  macos_privacy_setup
  macos_trackpad_setup

  killall Dock
  killall SystemUIServer
  killall Finder

  style yellow "Note that some of these changes require a logout/restart to take effect."
}

main() {
  style bold underline blue "Setting up macOS"

  setup_defaults

  style green "macOS setup complete"
}

main
