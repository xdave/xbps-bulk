#!/bin/sh

printf "INFO: Finding pkgnames from changed files...\n"

__PKGS="${*}"
XBPS_SRCPKGDIR="srcpkgs"

for __p in ${__PKGS}; do
	touch repo-checkvers.txt
	__f=$(echo ${__p} | grep srcpkgs)
	if [ -n "${__f}" ]; then
		__pkg=$(echo ${__f} | awk -F/ '{print $2}')
		if [ -d "srcpkgs/${__pkg}" ]; then
			. "srcpkgs/${__pkg}/template"
			__ver="${version}"
			__ver="${__ver}_${revision}"
			__repover="$(xbps-query -R -pversion ${__pkg})"
			xbps-uhelper cmpver ${__repover} ${__ver} > /dev/null 2>&1
			if [ ! $? -eq 0 ]; then
				echo "- ${__pkg} repover" >> repo-checkvers.txt
			fi
		fi
	fi
done
