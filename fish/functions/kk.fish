function kk -d "Start a kakoune server or client"
    set cur_dir (basename $PWD | tr -d '.' | tr '_' '-')
    set git_dir (basename (git rev-parse --show-toplevel 2> /dev/null; or pwd) | tr -d '.' | tr '_' '-')
    kak -clear; kak -clear
    if jobs | grep -q kak
        fg %(jobs | grep kak | grep -Eo '^[[:digit:]]+') > /dev/null
    else if kak -l | grep -q "^$cur_dir\$"
        kak -c $cur_dir $argv
    else if kak -l | grep -q "^$git_dir\$"
        kak -c $git_dir $argv
    else
        kak -s $cur_dir $argv
    end
end
