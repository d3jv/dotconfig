# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source bash completions
if [ -f .bash_completions ]; then
	. .bash_completions
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
alias lstr='ls --tree'
alias lltr='ll --tree'
alias '?'='echo $?'
alias packages='xbps-query -l | awk '"'"'{ print $2 }'"'"' | xargs -n1 xbps-uhelper getpkgname'
alias fpackages='packages | fzf'
alias fhistory='history | fzf --tac'
# NOTE: xargs -o doesn't work on BSD
alias fdiff='git status --short | grep -E '"'"'^ M'"'"' | awk '"'"'{ print $2 }'"'"' | fzf --cycle --preview="git diff --color {}" --print0 | xargs -r -o -0 vim'
alias fd=fdiff

fgit() {(
	__fgit_preview() {
		MODE=$(echo -n "${1:0:2}")
		FILE=$(echo -n "$1" | awk '{ print $2 }')

		case $MODE in
			" M")
				bat --diff --color=always $FILE
				;;
			*)
				bat --color=always --line-range=:500 $FILE
				;;
		esac
	}

	export -f __fgit_preview

	git status --short | \
	fzf --cycle --multi --preview="__fgit_preview {}" | \
	awk '{ print $2 }' | \
	xargs git $@
	# TODO: Figure out a way to use interactive git commands
	#	the function ends here and so "git add -p" gets cancelled
)}
fman() {
	apropos . -s "$1" | fzf -e -i --no-sort | sed 's/^\([^, (]*\).*/\1/' | xargs man "$1"
}
toilet-lsfonts() {
	for I in $(ls /usr/share/figlet); do
		echo ${I%.tlf} | toilet --font=${I%.tlf};
	done
}

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

