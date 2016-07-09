# PytSite Application Setup

## Usage

```
wget -qO - https://raw.githubusercontent.com/pytsite/setup/master/pytsite-setup.sh | bash -s PROJECT_NAME
```

or 

```
curl -s https://raw.githubusercontent.com/pytsite/setup/master/pytsite-setup.sh | bash -s PROJECT_NAME
```

then

```
cd PROJECT_NAME
```

edit your configuration file, usually `app/config/default.yml`, and then

```
./console setup
```

