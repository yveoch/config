#!/bin/bash

# Quit if non-interactive
[[ "$-" != *i* ]] && return

# PROMPT
PROMPT_COMMAND=__prompt_command
__prompt_command() {
	local errcode=$?
	local arrow=">\[\e[m\]"
	local nope="\e[0m\[\e[m\]"
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
	git=$(__git_ps1 "on \[\e[36m\]%s\[\e[m\]" 2> /dev/null)

	PS1=""
	type __prompt_command_local &> /dev/null && __prompt_command_local
	PS1="$nope\[\e[34m\]\u\[\e[m\] at \[\e[35m\]\h\[\e[m\] in \[\e[33m\]\w\[\e[m\] $git$PS1\n$arrow "
}
# Header
[[ $- == *i* ]] && type fortune &> /dev/null && fortune

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
export HISTCONTROL="ignoreboth"
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

# EXPORTS
export HOME=~
export PATH=$HOME/.scripts:$HOME/.local/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export EDITOR=kak
export VISUAL=kak
export TERM=screen-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8 &> /dev/null
export PYTHONSTARTUP=~/.pythonrc

# ALIASES
alias tcb="xclip -i -selection clipboard"
alias l="ls -lah"
alias rlwrap="rlwrap -c -i -m -r -R -s 50000"
alias menuconfig="make MENUCONFIG_COLOR=blackbg menuconfig"
alias ls="ls --color=auto"
alias dir="dir --color=auto"
alias grep="grep --color=auto"
alias ip="ip -c"
alias yaourt="yaourt --noconfirm"
alias py="python3"

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
e() {
	local cur_dir=$(basename $PWD | tr -d '.' | tr '_' '-')
	local git_dir=$(basename $(git rev-parse --show-toplevel 2> /dev/null || pwd) | tr -d '.' | tr '_' '-')
	kak -clear; kak -clear
	if jobs %kak &> /dev/null
	then
		fg %kak
	elif kak -l | grep -q "^$cur_dir$"
	then
		kak -c $cur_dir "$@"
	elif kak -l | grep -q "^$git_dir$"
	then
		kak -c $git_dir "$@"
	else
		kak -s $cur_dir "$@"
	fi
}

# TMUX
alias tmuxa="tmux attach"
alias tmuxd="tmux detach"
# Attach if exists else create
tm() {
	if ! tmux ls &> /dev/null
	then
		exec tmux $@
	else
		exec tmux attach -t ${1:-$(tmux ls | head -n 1 | cut -d ':' -f 1)}
	fi
}

# GODOC
godoc() {
	$(which godoc) $@ | less -FRX
}

revise() {
	local log
	if git log --oneline | grep -q 'origin/master'
	then
		log="git log HEAD...origin/master"
	else
		log="git log -n 10"
	fi
	git revise $($log --oneline --color=always | fzf --ansi --tac | cut -d ' ' -f 1)
}

# SSH-AGENT
if type keychain &>/dev/null
then
	eval `keychain -q --eval`
fi

# PLUGINS
if [ -d ~/.config/bash ]; then
	source ~/.config/bash/z/z.sh
	source ~/.config/bash/fz/fz.sh
	source ~/.config/bash/nt.sh
fi

# LOCAL
[ -f ~/.bashrc_local ] && source ~/.bashrc_local || true
