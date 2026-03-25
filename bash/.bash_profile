# .bash_profile

if [ -f ~/.profile ]; then
    . ~/.profile
fi

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
. "$HOME/.cargo/env"
