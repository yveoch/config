test (uname) = "Darwin"; or exit

fish_add_path -p /opt/homebrew/bin

fish_add_path -p (/bin/ls -d /opt/homebrew/opt/*/libexec/gnubin)
set MANPATH (/bin/ls -d /opt/homebrew/opt/*/libexec/gnuman) (manpath | tr ':' ' ')

fish_add_path -p (/bin/ls -d /opt/homebrew/opt/python@*/bin | sort -r)

alias coffee="caffeinate -disu"

source /opt/homebrew/share/fish/vendor_completions.d/*
