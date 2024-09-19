# ALIASES
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

# FUNCTIONS

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
