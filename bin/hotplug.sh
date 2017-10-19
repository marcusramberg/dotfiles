#!/bin/bash

set -o pipefail

export DISPLAY=:0.0
export XAUTHORITY=/home/foobar/.Xauthority

function connect(){
   logger -t udev "$1 connected"
   xrandr --output $1 --auto --right-of eDP-1
}

function disconnect(){
   logger -t udev "$1 disconnected"
   xrandr --output $1 --off
}

query=$(xrandr --query)
connected_output=$(echo "${query}" | egrep "^[A-Z0-1]+ connected \(" | awk -F' ' '{print $1}')
if [[ $? == 0 ]]; then
   echo "Connecting $connected_output"
   connect $connected_output
else
   disconnected_output=$(echo "${query}" | egrep "^[A-Z0-1]+ disconnected [0-9]+x[0-9]+\+[0-9]+\+[0-9]+" | awk -F' ' '{print $1}')
   if [[ $? == 0 ]]; then
      echo "Disconnecting $disconnected_output"
      disconnect $disconnected_output
   fi
 fi
