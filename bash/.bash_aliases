###########
# ALIASES #
###########

## basic ##
alias ls='lsd'
alias ll='lsd -la'
alias lstr='ls --tree'
alias lltr='ll --tree'
alias '?'='echo $?'

## void ##
alias packages='xbps-query -l | awk '"'"'{ print $2 }'"'"' | xargs -n1 xbps-uhelper getpkgname'

## fzf ##
alias fpackages='packages | fzf'
alias fhistory='history | fzf --tac'
alias fdiff='git status --short | grep -E '"'"'^ M'"'"' | awk '"'"'{ print $2 }'"'"' | fzf --cycle --preview="git diff --color {}" --print0 | xargs -r -o -0 vim'
alias fd=fdiff

## vim ##
alias vim=vim-huge
# vim but not an IDE
alias vi='vim +"let g:ale_enabled = 0" +"let g:coc_start_at_startup = 0" +"syntax off"'

## git ##
alias g=git
alias gs='git status'
alias gsw='git switch'
alias gd='git diff'
alias ga='git add'
alias gap='git add -p'
alias gg='git pull'
alias gp='git push'
alias gr='git restore'
alias grs='git restore --staged'
alias gc='git commit'
alias gcm='git commit -m'
alias gcam='git commit -a -m'

## other ##
alias adminer='sudo docker run --rm -p 8080:8080 --network=host -it adminer'
alias quickshow='quickshow --config /home/dave/quickevent/quickshow.conf'

#############
# FUNCTIONS #
#############

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

	git diff --name-only --relative --diff-filter=d | \
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
randpw(){ < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo; }
