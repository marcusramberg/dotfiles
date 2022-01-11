#!/usr/bin/env sh
#:diamond_shape_with_a_dot_inside: $scr/ansifix --> pipe through to really drive the point home
#▸       ▄▄▄▄                         █████  ▄███▀███▄  █████   ▄▄▄       
#▸   ▄███ ████  ████▀███▄  ▄███▀███▄  █████  ████ ████  █████  ████ ████  
#▸   ████ ████  ████ ████  ▀███▄▄▄▄   █████  ████       █████  ▀███▄███▄  
#▸   ▄▄▄▄▄████  ████ ████  ▄▄▄▄ ████  ▀▀▀▀▀  ████▀▀     ▀▀▀▀▀  ████ ████  
#▸   ████▄████  ████ ████  ████▄███▀  █████  ████       █████  ████ ████  
font="/usr/local/share/tdfiglet/fonts/brndamgx.tdf"
# Check to see if a pipe exists on stdin.
if [ -p /dev/stdin ]; then
    # OMG DATA WAS PIPED!!!1! 
    sed 's/40m /0m /g'
    exit 0
else
    # LAYER 8 PROBLEM. AGAIN
    tdfiglet -f "$(font)" 'ansifix'
    echo "Usage: <your_shitty_script> | <my_superior_script_$(basename $0)>"
    echo "  Strips unprintables from piped tdfiglet ANSI."
fi
