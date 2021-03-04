test (uname) = "Darwin"; or exit

set PATH (/bin/ls -d /usr/local/opt/*/libexec/gnubin) $PATH
set MANPATH (/bin/ls -d /usr/local/opt/*/libexec/gnuman) (manpath | tr ':' ' ')

set PATH (/bin/ls -d /usr/local/opt/python@*/bin | sort -r) $PATH

alias coffee="caffeinate -disu"
