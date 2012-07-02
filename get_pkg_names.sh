#!/bin/sh

__PKGS="${*}"

rm -f repo-checkvers.txt
touch repo-checkvers.txt

for __p in ${__PKGS}; do
	__f=$(echo ${__p} | grep srcpkgs)
	if [ -n "${__f}" ]; then
		__pkg=$(echo ${__f} | awk -F/ '{print $2}')
		if [ -d "srcpkgs/${__pkg}" ]; then
			. "srcpkgs/${__pkg}/template"
			__ver="${version}"
			__ver="${__ver}_${revision}"
			__repover="$(xbps-repo show -oversion ${__pkg})"
			xbps-uhelper cmpver ${__repover} ${__ver} > /dev/null 2>&1
			if [ ! $? -eq 0 ]; then
				echo "- ${__pkg} repover" >> repo-checkvers.txt
			fi
		fi
	fi
done
cat repo-checkvers.txt
