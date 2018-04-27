#!/bin/bash

# Quit if non-interactive
[[ "$-" != *i* ]] && return

# PROMPT
PROMPT_COMMAND=__prompt_command
__prompt_command() {
	local errcode=$?
	local arrow=">\[\e[m\]"
	local git=""
	if [ $errcode != 0 ]; then
		arrow="\[\e[31m\]$arrow"
	else
		arrow="\[\e[32m\]$arrow"
	fi

	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_SHOWSTASHSTATE=true
	GIT_PS1_SHOWUNTRACKEDFILES=true
	GIT_PS1_SHOWUPSTREAM="auto"
	GIT_PS1_DESCRIBE_STYLE="branch"
	GIT_PS1_SHOWCOLORHINTS=true
	git=$(__git_ps1 "on \[\e[33m\]%s\[\e[m\]" 2> /dev/null)

	PS1="\[\e[36m\]\u\[\e[m\] at \[\e[35m\]\h\[\e[m\] in \[\e[34m\]\w\[\e[m\] $git\n$arrow "
}
# Header
[[ $- == *i* ]] && type fortune &> /dev/null && fortune -s

# GENERAL SETTINGS
# Prevent file overwrite when redirecting
set -o noclobber
# Update window size after every command
shopt -s checkwinsize
# Enable history expansion with space
bind Space:magic-space
# Turn on recursive globbing
shopt -s globstar 2> /dev/null
# Case-insensitive globbing
shopt -s nocaseglob
# Don't change my shell colors
LS_COLORS=

# COMPLETION
[[ -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion
# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"
# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"
# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"
# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

# HISTORY
# Eternal history
export HISTSIZE=
export HISTFILESIZE=
# Don't record some commands
export HISTIGNORE="ls:bg:fg:history"
# Use standard ISO 8601 timestamp
export HISTTIMEFORMAT="%F %T "
# Avoid duplicate entries
export HISTCONTROL="ignoredups:erasedups"
# Save multi-line commands as one command
shopt -s cmdhist
# Append to the history file when exiting
shopt -s histappend
# At each prompt, append to history
PROMPT_COMMAND="$PROMPT_COMMAND; history -a"
# Enable incremental history search with up/down arrows
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# NAVIGATION
# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null
# Targets for cd completion
#CDPATH=~
# cd into environment variables
shopt -s cdable_vars

# ALIASES
alias tcb="xclip -i -selection clipboard"
alias l="ls -lah"
alias v="vim"
alias path="readlink -f"
alias rlwrap="rlwrap -c -i -m -r -R -s 50000"
alias menuconfig="make MENUCONFIG_COLOR=blackbg menuconfig"
alias ls="ls --color=auto"
alias dir="dir --color=auto"
alias grep="grep --color=auto"

# EXPORTS
export HOME=~
export PATH=$HOME/.scripts:$HOME/.local/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export EDITOR=vi
export VISUAL=vim
export TERM=screen-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8 &> /dev/null
export PYTHONSTARTUP=~/.pythonrc

# FZF
if source ~/.fzf.bash &> /dev/null; then
	# Open in tmux pane if possible
	alias fzf="fzf-tmux"
	# Faster with ag
	if type ag &> /dev/null; then
		FZF_DEFAULT_COMMAND="ag -g ''"
		FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
	fi
	# Preview dirs with tree
	if type tree &> /dev/null; then
		FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
	fi
fi

# KAKOUNE
# Automatic session naming
kk() {
	local base_dir=$(git rev-parse --show-toplevel 2> /dev/null || pwd)
	local project=$(basename $base_dir)
	if kak -l | grep -q $project; then
		kak -c $project "$@"
	else
		kak -s $project "$@"
	fi
}

# TMUX
alias tmuxa="tmux attach"
alias tmuxd="tmux detach"
# Attach if exists else create
tt() {
	if ! tmux attach $@ &> /dev/null; then
		tmux $@
	fi
}

# PLUGINS
if [ -d ~/.config/bash ]; then
	source ~/.config/bash/z/z.sh
	source ~/.config/bash/fz/fz.sh
	source ~/.config/bash/nt.sh
fi

# LOCAL
[ -f ~/.bashrc_local ] && source ~/.bashrc_local || true
