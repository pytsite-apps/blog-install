#!/bin/bash

REPO_URL="https://github.com/pytsite/application/archive/master.zip"

[ -z $1 ] && { echo 'Please specify your project name'; exit 1; }
[ -d $1 ] && { echo "Project directory '$1' is already exists"; exit 1; }

wget ${REPO_URL}
unzip master.zip
mv application-master $1
rm -fv master.zip
rm -fv $1/CHANGELOG.md
echo "# $1" > $1/README.md

cd $1 && virtualenv env && source ./env/bin/activate && pip install pytsite
[ $? -ne 0 ] && { echo 'Virtual environment setup error'; exit 1; }

echo ''
echo 'Setup has been completed successfully'
echo "Now you should edit configuration file(s) and run './console setup'"
