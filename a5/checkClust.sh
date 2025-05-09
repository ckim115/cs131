#!/bin/bash

CLUSTER=$1
echo "For cluster $CLUSTER:"
awk -v n="$CLUSTER" 'BEGIN{FS=","} { if (index($10, n)) clust[$1]++ } END {for (c in clust) printf "%s: %d\n", c, clust[c] }' clusters19.csv

