#!/bin/bash

CLUSTER=$1
awk -v n="$CLUSTER" 'BEGIN{FS=","} {if (index($10, n)) print $0 }' clusters.csv
