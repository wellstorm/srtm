#!/bin/bash

# usage: from-zip-to-json files...

set -e

USAGE="Usage: from-zip-to-json files..."
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TEMPDIR="$DIR"/../tmp
if [ "$#" == "0" ]; then
	echo "$USAGE"
	exit 1
fi


while (( "$#" )); do
    #Each SRTM file ends in .hgt.zip. Extract the lat, lon part of the name e.g. N25W098
    LATLON=`basename -s .hgt.zip $1`
    #unzip the file
    /usr/bin/unzip -d "$DIR"/../tmp "$1" 
    #the result is a binary file named N25W098.hgt
    #translate the binary to text
    dd conv=swab < "$TEMPDIR"/$LATLON.hgt | hexdump -dv | perl -p -i -e 's/^[0-9a-f]{7}//' |perl -p -i -e  's/\s+([0-9a-f]+)/\1\n/g' | sed -n '/[a-z0-9]/ p' > "$TEMPDIR"/$LATLON.txt
    # convert the text fle to 3600 little json files, one second by one second
    # the resulting files will be in e.g. ../json/N25W098/
    ruby -I"$DIR"/../lib "$DIR"/../lib/60.rb  -o "$DIR"/../json "$TEMPDIR"/$LATLON.txt 
shift

done

