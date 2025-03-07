#!/bin/bash

# TODO: add specification on whether to delete based on
#	1) creation date (-c)
#	2) last modified (-m, default)
#	3) last accessed (-a)

# Remove all files modified before or during a given date
FILE=$1
DATE=$2
ARGS=$3 
# If given 'w' will not produce warnings
# If given 's' will only remove files of specified date
# If given 'f' will only remove files

date_sec=$(date -d "$DATE" +%s) # Date removed by, converted into seconds. Required.
file_date=$(stat -c %y "$FILE" | cut -d ' ' -f1) # Actual file date
file_date_sec=$(date -d "$file_date" +%s) # In seconds

# Check to make sure it is a file or directory
# If directory, remove each file within it first 
if [ -f "$FILE" ]; then
	:
elif [ -d "$FILE" ]; then
	# There are files in the directory
	if [[ -n $(ls "$FILE") ]]; then
		# Go through each file recursively
		for i in "$FILE"/*; do
			"$0" "$i" "$DATE" "$ARGS"
		done
	fi
	# If argument 'f', do not remove directory
	if [[ "$ARGS" == *"f"* ]]; then
        	exit 0
	fi
else
	if [[ "$ARGS" != *"w"* ]]; then
		echo "File $FILE is not of valid type"
	fi
	exit 0
fi

# Remove files
if [[ "$ARGS" == *"s"* && ("$date_sec" -eq "$file_date_sec") \
       || "$date_sec" -ge "$file_date_sec" ]]; then
	rm -r "$FILE"
else
        if [[ "$ARGS" != *"w"* ]]; then
		echo "File $FILE was modified after $DATE"
        fi
fi

exit 0
