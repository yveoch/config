function awslogs
    set groups_file ~/.cache/awslogs/(set -q AWS_PROFILE; and echo $AWS_PROFILE; or echo "default").groups
    switch $argv[1]
        case 'cache'
            echo $groups_file
        case 'refresh'
            mkdir -p (dirname $groups_file)
            command awslogs groups | tee $groups_file
        case 'open'
            open (printf "https://console.aws.amazon.com/cloudwatch/home?#logsV2:log-groups/log-group/%s" (echo -n $argv[2] | jq -sRr @uri))
        case 'watch'
            command awslogs get -G -S -w $argv[2..] | grep --line-buffered "^{" | jq -c .
        case '*'
            command awslogs $argv
    end
end
complete --command awslogs --exclusive --condition __fish_use_subcommand --arguments 'cache refresh open watch get groups streams'
complete --command awslogs --exclusive --condition '__fish_seen_subcommand_from open watch get' --arguments '(cat (awslogs cache) | fzf)'
