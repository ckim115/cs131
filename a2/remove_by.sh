#!/bin/bash

# Remove all files modified before or during a given date
FILE=$1
DATE=$2
ARG=$3 
# If given 'w' will not produce warnings
# If given 's' will only remove files of specific date
# If given 'd' will not remove directories
# If given 'f' will not remove files

date_sec=$(date -d "$DATE" +%s) # Date removed by, converted into seconds. Required.
file_date=$(stat -c %y "$FILE" | cut -d ' ' -f1) # Actual file date
file_date_sec=$(date -d "$file_date" +%s) # In seconds

# Check to make sure it is a file or directory
# If directory, remove each file within it first 
if [ -f "$FILE" ]; then
	# If given argument f do not do anything to the file
	if [ "$ARG" == *"f"* ]; then
		exit 0
	fi
elif [ -d "$FILE" ]; then
	# There are files in the directory
	if [ -n "ls $FILE" ]; then
		# Go through each file recursively
		for i in "$FILE"/*; do
			"$0" "$i" "$DATE"
		done
	fi
else
	if [ "$ARG" == *"w"* ]; then
		echo "File $FILE is not of valid type"
	fi
fi

# If argument 'd', do not remove directory
# Do not need to worry about file as it wil already have terminated from -f above
if [ "$ARG" == *"d"* ]; then
	exit 0
fi

# Remove files
if [[ "$ARG" == *"s"* && "$date_sec" -eq "$file_date_sec" \
       || "$date_sec" -ge "$file_date_sec" ]]; then
	rm -r "$FILE"
else
        if [ "$ARG" == *"w"* ]; then
		echo "File $FILE was modified after $DATE"
        fi
fi

exit 0
