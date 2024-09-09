cd ~

# set superior keyboard layout
setxkbmap cz

# add Noto font paths
xset +fp /usr/share/fonts/noto
xset +fp /usr/share/fonts/TTF

export TERMINAL=konsole
export KDEWM=herbstluftwm

pipewire &
xbindkeys
xscreensaver &

# start herbstluft in locked mode, it will be unlocked at the end of autostart
# exec herbstluftwm --locked
