#!/bin/sh

## Use only the built-in display

xrandr --output eDP --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-A-0 --off --output DisplayPort-0 --off

xrdb -load ~/.Xresources-FHD

herbstclient reload
