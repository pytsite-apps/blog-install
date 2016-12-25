#!/bin/bash

APP_REPO_URL="https://github.com/pytsite/blog.git"
THEME_REPO_URL="https://github.com/pytsite/theme-blog-default.git"

[ -z $1 ] && { echo 'Please specify your project name'; exit 1; }
[ -d $1 ] && { echo "Project directory '$1' is already exists"; exit 1; }

mkdir $1 || { echo 'Error while creating project directory'; exit 1; }

cat <<'EOF' > $1/console
#!/bin/bash

source ./env/bin/activate
python -m pytsite $1 $2 $3 $4 $5 $6 $7 $8 $9
EOF

chmod 0755 $1/console

cat <<'EOF' > $1/wsgi.py
from pytsite.wsgi import application
EOF

# Clone application
git clone ${APP_REPO_URL} $1/app || { echo 'Error while cloning application'; exit 1; }

# Clone theme
cd $1 && mkdir themes && cd themes && git clone ${THEME_REPO_URL} blog-default && cd ..
[ $? -ne 0 ] && { echo 'Error while cloning theme'; exit 1; }

# Setup virtual environment
virtualenv env && source ./env/bin/activate && pip install pytsite && cd ..
[ $? -ne 0 ] && { echo 'Virtual environment setup error'; exit 1; }

# Make necessary files
mkdir $1/config
cat <<EOF > $1/config/default.yml
server_name: $1

db:
  host: localhost
  database: test
  user: user
  password: password
  ssl: false
EOF

echo ''
echo 'Setup has been completed successfully'
echo "Now you should edit configuration file(s) and run './console setup'"
