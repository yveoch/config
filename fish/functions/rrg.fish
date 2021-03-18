function rrg -d "Replace ripgrep"
    if test (count $argv) -lt 1 -o (count $argv) -gt 2
        echo "rrg <search> [replace]" >&2
        return 1
    else if test (count $argv) -eq 1
        rg -l $argv[1]
    else
        set tmp (mktemp)
        for file in (rg -l $argv[1])
            rg --passthru $argv[1] -r $argv[2] $file > $tmp
            cp $tmp $file
        end
        rm $tmp
    end
end
