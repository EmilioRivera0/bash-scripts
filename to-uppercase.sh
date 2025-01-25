#! /bin/sh

# Transform lines of text contained in a file into Title Formatted Text using sed command
# Command Arguments:
#   1: absolute or relative path of the target filename

# Check if filename argument was specified
if (($# < 1))
then
	echo "Missing Path to Target File"
	exit 1
else
  echo "Target File: $1"
fi

# set Internal Field Separator to end of line to process lines with multiple words
IFS=$'\n'
# save the output in a list if further processing is needed
result=$(sed -E 's/\b([a-z])/\U\1/g' $1)

# output the result into the specified file
printf "%b\n" ${result[@]} > $1

echo -e "Done modifying $1 file\n"

