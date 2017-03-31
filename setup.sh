#!/bin/bash

APP_REPO_URL="https://github.com/pytsite/blog.git"
THEME_NAME="default"

[ -z $1 ] && { echo 'Please specify your project name'; exit 1; }
[ -d $1 ] && { echo "Project directory '$1' is already exists"; exit 1; }

mkdir $1 || { echo 'Error while creating project directory'; exit 1; }

[ ! -z $2 ] && THEME_NAME=$2
THEME_REPO_URL="https://github.com/pytsite/theme-blog-${THEME_NAME}.git"

# Clone application
git clone ${APP_REPO_URL} $1/app || { echo 'Error while cloning application'; exit 1; }

# Clone theme
cd $1 && mkdir themes && cd themes && git clone ${THEME_REPO_URL} blog-${THEME_NAME} && cd ..
[ $? -ne 0 ] && { echo 'Error while cloning theme'; exit 1; }

# Setup virtual environment
virtualenv env && source ./env/bin/activate && pip install pytsite && cd ..
[ $? -ne 0 ] && { echo 'Virtual environment setup error'; exit 1; }

# Make necessary files
mkdir $1/config
cat <<EOF > $1/config/default.yml
server_name: test.com

db:
  host: localhost
  database: test
  # user: user
  # password: password
  # ssl: true

languages: [en, uk, ru]

plugman:
  license: okyvhqHvxw73eLZANrWhSsBAqSZ7369F6vhCfBDfKLcL2g9fBDnrGa9xf42gX8d9
  plugins:
    - article
    - page
    - content_digest
    - addthis
    - disqus
    - seo
EOF

echo ''
echo 'Setup has been completed successfully'
echo "Now you should edit configuration file(s) and run './console setup'"
