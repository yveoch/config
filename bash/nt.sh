#!/usr/bin/env sh

NOTES=$HOME/.notes

mkdir -p $NOTES

nt() {
	local extension=".md"
	local notes=$(find $NOTES -name "*$extension" -exec basename {} \; | sed "s/$extension$//" | sort)

	if [ $# == 0 ]; then
		echo "$notes"
	else
		local match=$(echo "$notes" | grep -iE "$1")

		if [ "$match" ]; then
			pushd $NOTES &> /dev/null
			$EDITOR "$match.md"
			popd &> /dev/null
		else
			pushd $NOTES &> /dev/null
			$EDITOR "$1.md"
			popd &> /dev/null
		fi
	fi
}

_fzf_complete_nt() {
	_fzf_complete '+m' "$@" < <(
	nt
	)
}
complete -F _fzf_complete_nt -o default -o bashdefault nt
