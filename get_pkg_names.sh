#!/bin/sh

__PKGS="${*}"

rm -f repo-checkvers.txt
touch repo-checkvers.txt

for __p in ${__PKGS}; do
	__f=$(echo ${__p} | grep srcpkgs)
	if [ -n "${__f}" ]; then
		. ${__f}
		__ver="${version}"
		__ver="${__ver}_${revision}"
		__dir=$(dirname ${__f})
		__pkg=$(basename ${__dir})
		__repover="$(xbps-repo show -oversion ${__pkg})"
		echo ${__pkg}
		echo ${__ver}
		echo ${__repover}
		xbps-uhelper cmpver ${__repover} ${__ver}
		if [ $? -gt 0 ]; then
			echo "- ${__pkg} repover" >> repo-checkvers.txt
		fi
	fi
done
