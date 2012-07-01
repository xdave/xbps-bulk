#!/bin/sh

PKGS="$*"

rm -f repo-checkvers.txt

for p in $PKGS; do
	f=$(echo $p | grep srcpkgs)
	if [ -n "$f" ]; then
		dir=$(dirname $f)
		pkg=$(basename $dir)
		echo "- $pkg" >> repo-checkvers.txt
	fi
done
