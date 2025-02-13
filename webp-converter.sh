#! /bin/sh

# Convert the target image to webp format using ffmpeg
# Can work with filenames with more than one dot (.) inside them. It will only remove the file extension.
# Command Arguments:
#   1: target image to convert (this script expects a that the image has its type specified in its extension)

# Check if target image filename was specified
if (($# < 1))
then
	echo -e "Missing Path to Target Image\n"
	exit 1
else
  echo "Target Image: $1"
fi

# obtain the name of the image without the image type
name=$(echo $1 | rev | cut -d "." -f 2- | rev)

ffmpeg -i $1 "$name.webp"

echo -e "\nOutput: $name.webp"

