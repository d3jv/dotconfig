#!/bin/sh

xrandr --output eDP --off --output HDMI-A-0 --mode 1920x1200 --pos 0x0 --rotate normal --output DisplayPort-0 --off

xrdb -load ~/.Xresources-FHD

herbstclient reload
