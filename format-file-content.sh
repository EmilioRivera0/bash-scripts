#! /bin/sh

# Generate repetitive content for a file, where a given part of each repeated line will be subtituted
# with the content of each line contained in the file specified in the first command line argument and
# stored in the filename specified in the second command line parameter
# Command Arguments:
#   1: absolute or relative path of the target filename
#   2: absolute or relative path of the output filename

# Check if filename argument was specified
if (($# < 2))
then
	echo "Missing Path to Target File and/or Path to Output File"
	exit 1
else
  echo "Target File: $1"
  echo "Output File: $2"
fi

# variable containing the string that will be repeated on the output file
# This string will be used as the first parameter of the printf command, 
# so use %b or %p to specify where you want to insert content from each line
# from the target file.
template="./states/post.sh \"%b\""
# Dont forget the new line character '\n'
template+="\n"

# set Internal Field Separator to end of line to process lines with multiple words
IFS=$'\n'
# save the content of the target file
result=$(cat $1)

# output the result into the specified file
printf $template ${result[@]} >> $2

echo -e "Formatted Output File $1 Finished\n"

