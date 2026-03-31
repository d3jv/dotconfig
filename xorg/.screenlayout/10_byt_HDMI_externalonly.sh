#!/bin/sh
xrandr --output eDP --off --output HDMI-A-0 --mode 2560x1440 --pos 0x0 --rotate normal --rate 144 --output DisplayPort-0 --off

xrdb -load ~/.Xresources-QHD

herbstclient reload
