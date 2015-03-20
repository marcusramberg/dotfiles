#!/bin/bash

i3status -c ~/.i3/i3status.conf | while :
do
    read line
    free=$(df -h / |tail -1| perl -nE'@f=split;say $f[3]')
    brightness="$(cat /sys/class/backlight/intel_backlight/actual_brightness)*100/805"
    echo "  ${free} free |  $(echo $brightness | bc)% | $line" || exit 1
done
