#! /bin/sh

# Script for building a website's static files (from any framework that supports npm run build)
# and deploying this files to a Github Pages repository that is found inside DIST_DIR directory
# *If DIST_DIR and OUTPUT_DIR are not found in the root directory of where this script is being called,
# the respective modifications to this script need to be done for it to work correctly
# *DIST_DIR must have a git project already initialized that points to its respective Github Pages repository

# directory where static export files will be generated
OUTPUT_DIR='out/'
# directory to copy the newly builded static export files to Deployed
DIST_DIR='dist/'

# alias for the remote git repo
REMOTE='origin'

# create dist directory if it is not present
if [[ -d $DIST_DIR ]]; then
  echo -e "\ndist/ directory found"
else
  echo -e "\ndist/ directory not found"
  echo -e "Create dist/ directory and initialize the target Git Repo to deploy to!\n"
  exit 1
fi

# cd into DIST_DIR
cd $DIST_DIR

# update local git repo
git pull

# go back to root directory
cd ..

# build static export files
npm run build

# cd into DIST_DIR
cd $DIST_DIR

# set Internal Field Separator to end of line '\n' to process files/directories with spaces
IFS=$'\n'
# get all the previous files and directories from DIST_DIR except .git/ directory and .nojekyll file
result=$(find . -mindepth 1 -maxdepth 1 -type d -name ".git" -prune -o -type f -name ".nojekyll" -prune -o -print)

# remove all the previous directories and files
if [[ -n $result ]]
then
  rm -r $result
fi

# copy the newly built static export files into DIST_DIR
cp -r "../$OUTPUT_DIR." .

# add new changes to github pages repo
git add .
git commit -m "Deployment $(date)"
git push -u $REMOTE

echo -e "\nWeb Page Deployed!\n"

