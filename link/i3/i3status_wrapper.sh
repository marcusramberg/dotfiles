#!/bin/bash

i3status -c ~/.i3/i3status.conf | while :
do
    read line
    free=$(df -h / |tail -1| perl -nE'@f=split;say $f[3]')
    max_brightness=$(cat /sys/class/backlight/*/max_brightness)
    brightness="$(cat /sys/class/backlight/*/actual_brightness)*100/$max_brightness"
    echo "  ${free} free |  $(echo $brightness | bc)% | $line" || exit 1
done
