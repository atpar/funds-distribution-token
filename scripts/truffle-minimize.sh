#!/bin/bash

# $1 - path to directory containing truffle artifacts
# $2 - path to directory where minimified artifacts should be stored

echo ""

if [ -z "$1" ]; then
	echo "No directory for truffle artifacts was specified."
	echo ""
	exit 1
fi

if [ -z "$2" ]; then
	echo "No output directory was specified."
	echo ""
	exit 1
fi

if [ ! -d "$1" ]; then
	echo "No $(tput bold)build/$(tput sgr0) directory found."
	echo "Generate truffle artifacts first by executing $(tput bold)yarn compile$(tput sgr0)."
	echo ""
	exit 1
fi

[ -d $2 ] || mkdir $2

for i in "$1"/*.json; do
	m=$2/$(basename "${i%%.json}.json")
	# [ -e $m ] && continue
	echo "Minimizing truffle json artifact: $i"
	echo "Original size:  $(wc -c "$i")"
	jq 'del(.ast,.legacyAST,.source,.deployedSourceMap,.userdoc,.deployedBytecode,.sourceMap,.sourcePath,.schemaVersion,.devdoc)' $i > $m
	echo "Minimized size: $(wc -c "$m")"
done
