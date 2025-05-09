#!/bin/bash

TYPE=$1
echo "For type $TYPE:"
awk -v n="$TYPE" 'BEGIN{FS=","} { if (index($1, n)) clust[$10]++ } END {for (c in clust) printf "%s: %d\n", c, clust[c] }' clusters19.csv
