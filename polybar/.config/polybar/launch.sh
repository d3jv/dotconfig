#!/bin/bash

# Terminate already running polybar instances
polybar-msg cmd quit

polybar example 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar started..."
