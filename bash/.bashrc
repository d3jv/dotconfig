# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source bash completions
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
fi

if [ -f /usr/share/bash-completion/completions/herbstclient ]; then
	. /usr/share/bash-completion/completions/herbstclient
fi

if [ -f /usr/share/bash-completion/completions/git ]; then
	. /usr/share/bash-completion/completions/git
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

# ALIASES and FUNCTIONS
alias ls='lsd'
alias ll='lsd -la'
alias '?'='echo $?'
alias packages='xbps-query -l | awk '"'"'{ print $2 }'"'"' | xargs -n1 xbps-uhelper getpkgname'
alias fpackages='packages | fzf'
alias fhistory='history | fzf --tac'
fman() {
	apropos . -s "$1" | fzf -e --no-sort | sed 's/^\([^, (]*\).*/\1/' | xargs man "$1"
}
toilet-lsfonts() {
	for I in $(ls /usr/share/figlet); do
		echo ${I%.tlf} | toilet --font=${I%.tlf};
	done
}
which zoxide >/dev/null 2>/dev/null && eval "$(zoxide init --cmd cd bash)"

# VARIABLES
export EDITOR=vim
export VISUAL=vim
export TERMINAL=konsole
export LESSCHARSET=utf-8
export CC=cc
export GPG_TTY=$(tty)

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

