#!/bin/bash

# Remove all files modified before or during a given date
FILE=$1 # Required
DATE=$2
DATE_SEC=$(date -d "$2" +%s) # Date removed by, converted into seconds. Required.

file_date=$(stat -c %y "$FILE" | cut -d ' ' -f1) # Actual file date
file_date_sec=$(date -d "$file_date" +%s) # In seconds

# Check to make sure it is a file or directory
# If directory, remove each file within it first 
if [ -f "$FILE" ]; then
	:
elif [ -d "$FILE" ]; then
	# There are files in the directory
	if [ -n "ls $FILE" ]; then
		# Go through each file recursively
		for i in "$FILE"/*; do
			"$0" "$i" "$DATE"
		done
	fi
else
	echo "File is not of valid type"
	exit 1;
fi

# Delete file
if [ "$DATE_SEC" -ge "$file_date_sec" ]; then
	rm -r "$FILE"
else
        echo "File was modified after $DATE"
fi

exit 0
