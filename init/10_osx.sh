# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || exit 0

# Logging stuff.
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;33m➜\033[0m  $@"; }


# Some tools look for XCode, even though they don't need it.
# https://github.com/joyent/node/issues/3681
# https://github.com/mxcl/homebrew/issues/10245
if [[ ! -d "$('xcode-select' -print-path 2>/dev/null)" ]]; then
  sudo xcode-select -switch /usr/bin
fi

if [[ ! "$(type -P gcc-4.2)" ]]; then
  e_header "Installing Homebrew dupe recipe: apple-gcc42"
  brew install https://raw.github.com/Homebrew/homebrew-dupes/master/apple-gcc42.rb
fi
