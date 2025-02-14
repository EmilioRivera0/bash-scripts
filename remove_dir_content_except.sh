#! /bin/sh

# Remove the contents of the specified directory except the pecified files or directoreis
# This script will exclude only the files and directories that are found in the first depth level of 
# the directory (the files and directoreis that are on the root of the target directory to remove its content).
# Command Arguments:
#   1: target directory to remove its content
#   2-n: files and/or directories that will not be removed

# Check if target image filename was specified
if (($# < 2))
then
	echo -e "Missing Path to Target Directory and at least 1 File/Directory to Exclude\n"
	exit 1
fi

# array to store the basenames of the files/directories to exclude
BASENAMES=()
# initial directory
INITIAL_DIR=$(pwd)
# target directory
TARGET_DIR=$1

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
    BASENAMES+=($temp)
  fi
done

# exclude expression
EXCLUDE_EXPRESSION=""
# generate the expression to exclude the files/directories from the find command
for IT in ${BASENAMES[@]}
do
  #EXCLUDE_EXPRESSION+="-not -path \"*/$IT\" "
  EXCLUDE_EXPRESSION+="-not -path */$IT "
done

# cd into target directory
cd $TARGET_DIR

# delete allowed TARGET_DIR's content using find command
find . -mindepth 1 -maxdepth 1 $EXCLUDE_EXPRESSION -delete

# cd to INITIAL_DIR
cd $INITIAL_DIR

# feedback the user
echo -e "\nTarget Directory $TARGET_DIR content removed!\n"

