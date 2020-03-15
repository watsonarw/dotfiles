#!/bin/sh

. $(dirname $0)/../commons.sh

# Sets reasonable macOS defaults.
#
# Some settings grabbed from:
#   https://github.com/albertoqa/dotfiles/blob/master/bin/macos.sh
#

###############################################################################
# General                                                                     #
###############################################################################

echo "Show Battery Percentage on the menu bar"
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

echo "Disable auto-correct spelling automatically"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "Show seconds and date in menu bar"
defaults write com.apple.menuextra.clock "DateFormat" "d MMM  hh:mm:ss"

echo "Use AirDrop over every interface."
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

###############################################################################
# Finder                                                                      #
###############################################################################

echo "Always open everything in Finder's list view. This is important."
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

echo "Show the ~/Library folder."
chflags nohidden ~/Library

echo "Set User home as the default location for new Finder windows"
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

echo "Show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

###############################################################################
# Keyboard                                                                    #
###############################################################################

echo "Set a fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 20

echo "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

###############################################################################
# Dock                                                                     #
###############################################################################

echo "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo "remove all icons from the dock"
defaults write com.apple.dock persistent-apps -array

echo "Set the Finder prefs for showing a few different volumes on the Desktop."
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

###############################################################################
# Security & Privacy                                                          #
###############################################################################

echo "Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0


###############################################################################
# Trackpad                       	                                      #
###############################################################################

echo "enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo_bold "${GREEN}Done. Note that some of these changes require a logout/restart to take effect.${RESET}"
