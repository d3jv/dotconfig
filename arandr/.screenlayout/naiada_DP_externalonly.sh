#!/bin/sh

## Use only external monitor on naiada machines at FI via DP

xrandr --output eDP --off --output HDMI-A-0 --off --output DisplayPort-0 --mode 1920x1200 --pos 0x0 --rotate normal
