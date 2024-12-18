function venv -d "Ensure a Python environment"
    test -f venv/bin/activate.fish || python3 -m venv venv
    source venv/bin/activate.fish
end
