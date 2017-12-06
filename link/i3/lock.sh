#!/usr/bin/env sh

revert() {
    xset dpms 0 0 0
}
trap revert HUP INT TERM
xset +dpms dpms 10 10 10
i3lock -n -i $HOME/.dotfiles/wallpaper/night.png \
    --insidecolor=37344500 --ringcolor=d23c3d44 --line-uses-inside \
    --keyhlcolor=d23c3d77 --bshlcolor=d23c3d77 --separatorcolor=00000000 \
    --insidevercolor=ffffff00 --insidewrongcolor=d23c3d00 \
    --ringvercolor=99999966 --ringwrongcolor=d23c3dbb --indpos="x+1440:y+900" \
    --radius=340 --veriftext="" --wrongtext="" --ring-width=10 \
    -k --indicator --timecolor=00000000 --datecolor=00000000 -t -S=0 \
    --timepos="ix640:iy480"
revert
