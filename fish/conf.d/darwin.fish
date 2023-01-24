test (uname) = "Darwin"; or exit

set PATH /opt/homebrew/bin $PATH

set PATH (/bin/ls -d /opt/homebrew/opt/*/libexec/gnubin) $PATH
set MANPATH (/bin/ls -d /opt/homebrew/opt/*/libexec/gnuman) (manpath | tr ':' ' ')

set PATH (/bin/ls -d /opt/homebrew/opt/python@*/bin | sort -r) $PATH

alias coffee="caffeinate -disu"
