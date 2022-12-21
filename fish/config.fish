alias clip "xclip -i -selection clipboard"
alias l "ls -lah"
alias pip "pip3"
alias py "python3"
alias ipy "ipython3"
alias python "python3"
alias tm "tmux attach -t 0; or tmux"

set PATH $HOME/.local/bin $PATH

alias e "hx"
set -U EDITOR "hx"
set -U VISUAL "hx"

set -x FZF_DEFAULT_COMMAND 'fd --type f'

set __fish_git_prompt_show_informative_status 1
set __fish_git_prompt_showcolorhints 1
