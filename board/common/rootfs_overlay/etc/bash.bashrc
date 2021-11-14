# System-wide .bashrc file for interactive bash(1) shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy color prompt
if [ "`id -u`" -eq 0 ]; then
	PS1='\[\033[01;31m\]\u\[\033[01;33m\]@\h\[\033[00m\]:\[\033[00;37m\]\w\[\033[00m\]> '
else
	PS1='\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[00;37m\]\w\[\033[00m\]> '
fi

# System Aliases
LS_OPTIONS="--color=always"
alias ..='cd ..'
alias nano='nano -K'
alias edit='nano -Asciw$'
alias ls='ls ${LS_OPTIONS}'
alias l='ls ${LS_OPTIONS} -Al'
export LC_ALL="C"

# Append backslash to directory symlinks
bind 'set mark-symlinked-directories on'

# Adjust terminal size for those running screen
if [ `tty` == "/dev/console" ]; then
	/usr/bin/resize
fi

