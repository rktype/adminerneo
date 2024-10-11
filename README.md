# Adminer container with Pematon Theme
Based on [Adminer (Pematon version)](https://github.com/pematon/adminer) with preinstalled [Pematon Theme](https://github.com/pematon/adminer-theme)
## Environment variables
### ADMINER_ENV
- `local` => green theme
- `dev` | `test` | `stage` | `staging` => blue theme
- `prod` | `production` => orange theme (default)
### ADMINER_DEFAULT_SERVER
Set the default server host
### ADMINER_DEFAULT_DRIVER
Set the default database driver
- `mysql`
- `sqlite`
- `sqlite2`
- `pgsql`
- `oracle`
- `mssql`
- `mongo`
- `elastic`