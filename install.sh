#!/bin/bash

APP_REPO_URL="https://github.com/pytsite-apps/blog.git"
THEME_NAME="basic"

[ -z ${1} ] && { echo 'Please specify your project name'; exit 1; }
[ -d ${1} ] && { echo "Project directory '${1}' is already exists"; exit 1; }

mkdir ${1} || { echo 'Error while creating project directory'; exit 1; }

[ ! -z ${2} ] && THEME_NAME=${2}
THEME_NAME=${THEME_NAME}-blog
THEME_REPO_URL="https://github.com/pytsite-themes/${THEME_NAME}.git"

# Clone application
git clone ${APP_REPO_URL} ${1}/app || { echo 'Error while cloning application'; exit 1; }
[ $? -ne 0 ] && { echo 'Error while cloning application'; exit 1; }

# Clone theme
cd ${1} && mkdir themes && cd themes && git clone ${THEME_REPO_URL} ${THEME_NAME} && cd ..
[ $? -ne 0 ] && { echo 'Error while cloning theme'; exit 1; }

# Remove unnecessary .git directories
rm -rf ./app/.git && rm -rf ./themes/${THEME_NAME}/.git

# Setup virtual environment
virtualenv env && source ./env/bin/activate && pip install pytsite && cd ..
[ $? -ne 0 ] && { echo 'Virtual environment setup error'; exit 1; }

# Make necessary files
mkdir ${1}/config
cat <<EOF > ${1}/config/default.yml
server_name: test.com

db:
  host: localhost
  database: test
  # user: user
  # password: password
  # ssl: true

languages: [en, uk, ru]

plugman:
  plugins:
    - auth_google
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
