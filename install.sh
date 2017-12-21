#!/bin/bash

APP_REPO_URL="https://github.com/pytsite-apps/blog.git"
THEME_NAME="basic"

[ -z ${1} ] && { echo 'Please specify your project name'; exit 1; }
[ -d ${1} ] && { echo "Project directory '${1}' is already exists"; exit 1; }

mkdir ${1} || { echo 'Error while creating project directory'; exit 1; }

[ ! -z ${2} ] && THEME_NAME=${2}
THEME_NAME=blog_${THEME_NAME}
THEME_REPO_URL="https://github.com/pytsite-themes/${THEME_NAME}.git"

# Clone application
git clone ${APP_REPO_URL} ${1}/app || { echo 'Error while cloning application'; exit 1; }
[ $? -ne 0 ] && { echo 'Error while cloning application'; exit 1; }

# Clone theme
cd ${1} && mkdir themes && cd themes && git clone ${THEME_REPO_URL} ${THEME_NAME} && cd ..
[ $? -ne 0 ] && { echo 'Error while cloning theme'; exit 1; }

# Setup virtual environment
virtualenv env && source ./env/bin/activate && pip install pytsite
[ $? -ne 0 ] && { echo 'Virtual environment setup error'; exit 1; }

# Install required plugins
cd app && ./console plugman:install && cd ..
[ $? -ne 0 ] && { echo 'Plugins installation error'; exit 1; }

# Make default configuration file
mkdir config
cat <<EOF > config/default.yml
server_name: test.com

db:
  host: localhost
  database: test
  # user: user
  # password: password
  # ssl: true

languages: [en, uk, ru]
EOF

echo ''
echo 'Setup has been completed successfully'
