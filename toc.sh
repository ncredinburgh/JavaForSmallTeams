#!/bin/bash
tocfile="generated/toc/$1.md"
: > $tocfile
echo $tocfile
for f in $(ls -v $1/*.md); do
  name=`basename $f .md`
  name=$(echo "$name" | sed -r 's/(^|_)([a-z])/ \U\2/g') 
  name=${name//_/ }
  echo "    * [${name#* }]($f)" >> "$tocfile"
done
