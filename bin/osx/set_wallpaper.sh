#! /bin/bash
#script to change all desktop backgrounds
function change_wallpaper {
  defaults write com.apple.desktop Background "{default = {ImageFilePath='$1'; };}"; killall Dock
}
change_wallpaper

