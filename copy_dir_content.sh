#! /bin/sh

# Copy the contents of one directory into the specified path
# Command Arguments:
#   1: path of the target directory from which the content will be copied from
#   2: path where the content will be copied to

# Check if target image filename was specified
if (($# < 2))
then
  echo -e "Missing Path of Target Directory to copy from and Path to the destination of the copies\n"
	exit 1
else
  echo "Directory of Origin: $1"
  echo "Destination Path: $2"
fi

cp -r $1/. $2

echo -e "\nContents from $1 copied to $2\n"

