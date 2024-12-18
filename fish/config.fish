fish_add_path -p $HOME/.local/bin

set -x GOPATH $HOME/.local/go
fish_add_path -a $HOME/.local/go/bin


if status is-interactive
    # Commands to run in interactive sessions can go here
    alias l "ls -lah"
    alias pip "pip3"
    alias py "python3"
    alias ipy "ipython3"
    alias python "python3"
    alias tm "tmux attach -t 0; or tmux"
    alias e "kk"

    set -gx EDITOR "kak"
    set -gx VISUAL "kak"

    set TERM screen-256color

    starship init fish | source
end
