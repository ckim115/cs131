#!/bin/bash

# Remove all files modified before or during a given date
if [ "$#" -lt 2 ]; then
	echo "must include file path and date!"
	exit 0
fi

FILE=$(eval "echo \$$(($#-1))")
DATE=$(eval "echo \$$(($#))")
ARGS=''
if [ "$#" -gt 2 ]; then
	ARGS=$1 
fi
# If given 'w' will not produce warnings
# If given 's' will only remove files of specified date
# If given 'f' will only remove files

date_acc="%y"
case $ARGS in
	*"c"*) 
		date_acc="%w"
		;;
	*"a"*)
		date_acc="%x"
		;;
	*)
		;;
esac

date_sec=$(date -d "$DATE" +%s) # Date removed by, converted into seconds. Required.
file_date=$(stat -c "$date_acc" "$FILE" | cut -d ' ' -f1) # Actual file date
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
			"$0" "$ARGS" "$i" "$DATE"
		done
	fi
	# If argument 'f' or there still remains files in the directory, do not remove directory
	if [[ "$ARGS" == *"f"* || -n $(ls "$FILE") ]]; then
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
	|| "$ARGS" != *"s"* && ("$date_sec" -ge "$file_date_sec") ]]; then
	if [[ "$ARGS" != *"w"* ]]; then
		echo "Removed $FILE"
	fi
	rm -r "$FILE"
else
        if [[ "$ARGS" != *"w"* ]]; then
		echo "File $FILE was not removed"
        fi
fi

exit 0
