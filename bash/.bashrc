# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source bash completions
if [ -f .bash_completions ]; then
	. .bash_completions
fi

if [ -f .bash_aliases ]; then
	. .bash_aliases
fi

# HISTORY

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

# PS1
__update_ps1() {
	if [[ $? -eq 0 ]]; then
		local SYMBOL='\$'
	else
		local SYMBOL='\[\e[31m\]\$'
	fi

	local PS1_START='\[\e[32m\][ \[\e[33m\]\t \[\e[32m\]\u \[\e[33m\]\w \[\e[32m\]]'
	local PS1_END='\[\e[m\]'
	PS1="$PS1_START $SYMBOL $PS1_END"
}

PROMPT_COMMAND='__update_ps1; history -a'

which zoxide >/dev/null 2>/dev/null && eval "$(zoxide init --cmd cd bash)"

# VARIABLES
export TZ="Europe/Prague"
export EDITOR=vim
export VISUAL=vim
export TERMINAL=konsole
export LESSCHARSET=utf-8
export CC=cc
export GPG_TTY=$(tty)
export GTK_THEME=Adwaita:dark
export QT_QPA_PLATFORMTHEME=qt5ct

# DOTNET SHIT
export DOTNET_ROOT=/opt/dotnet
# because dotnet ignores the variable when installing tools
#export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
export PATH=$PATH:$DOTNET_ROOT:$HOME/.dotnet/tools
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# PATH
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

. "$HOME/.cargo/env"
