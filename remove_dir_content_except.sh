#! /bin/sh

# Remove the contents of the specified directory except the pecified files or directoreis
# This script will exclude only the files and directories that are found in the first depth level of 
# the directory (the files and directoreis that are on the root of the target directory to remove its content).
# Command Arguments:
#   1: target directory to remove its content
#   2-n: files and/or directories that will not be removed

# array to store the basenames of the files/directories to exclude
basenames=()

# Check if target image filename was specified
if (($# < 2))
then
	echo -e "Missing Path to Target Directory and at least 1 File/Directory to Exclude\n"
	exit 1
fi

# Feedback the user with the target directory and files/directories to exclude
echo -e "Target Directory:\n\t$1"
echo -e "Files/Directories to Exclude:"

for IT in $@
do
  if [[ $IT != $1 ]]
  then 
    # feedback to user
    echo -e "\t$IT"
    # obtain the basename of the files/directories to exclude and save them to $basenames
    temp=$(basename $IT)
    basenames+=($temp)
  fi
done

