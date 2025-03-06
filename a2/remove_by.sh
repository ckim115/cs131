#!/bin/bash

# Remove all files modified before or during a given date
FILE=$1 # Required
DATE=$2
DATE_SEC=$(date -d "$2" +%s) # Date removed by, converted into seconds. Required.
ARG=$3 # If arguement -p given, print out the name of all files removed

file_date=$(stat -c %y remove_by.sh | cut -d ' ' -f1) # Actual file date
file_date_sec=$(date -d "$file_date" +%s) # In seconds

# If FILE meets DATE criteria or is a dir:
#	if FILE is a file, print name if "-p" given, and remove it
#	if File is a dir, call remove_by on all its children. 
#		if FILE no longer has any children and meets date criteria, remove it as well
if [[ "$DATE_SEC" -ge "$file_date_sec" || -z "ls -a $FILE" ]]; then
	if [ -f "$FILE" ]; then
		if [ "$ARG" == "-p" ]; then
			echo "$FILE"
		fi
		rm "$FILE"
	elif [ -d "$FILE" ]; then
		for i in "$FILE"/*; do
			"$0" "$i" "$DATE" "$ARG"
		done
		if [[ -z $(ls "$FILE") && "$DATE_SEC" -ge "$file_date_sec" ]]; then
			rm -r "$FILE"
		fi
	else 
		# TODO: check if not empty dir (in which case for loop); THEN check if empty
		echo "File is not of valid type"
	fi
else
	echo "File was modified after $DATE"
fi

echo "finished removing $FILE"

exit 0
