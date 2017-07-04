# PytSite Blog Installation Helper

## Usage

```
wget -qO - https://raw.githubusercontent.com/pytsite-apps/blog-install/master/install.sh | bash -s PROJECT_NAME
```

or

```
curl -s https://raw.githubusercontent.com/pytsite-apps/blog-install/master/install.sh | bash -s PROJECT_NAME
```

then

```
cd PROJECT_NAME
```

edit your configuration file, usually `config/default.yml`, and then

```
./console setup
```

