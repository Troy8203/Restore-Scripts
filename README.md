# GNOME Extensions Backup & Restore Script

This script backs up and restores GNOME Shell extensions using `dconf`.

## Usage

### Run Locally
Backup all extensions:
```sh
./backup-extensions.sh
```
Restore from a backup:
```sh
./backup-extensions.sh backup_YYYY-MM-DD.tar.gz
```

### Run with `curl`
Backup:
```sh
curl -s https://your-repository-url/backup-extensions.sh | bash
```
Restore:
```sh
curl -s https://your-repository-url/backup-extensions.sh | bash -s backup_YYYY-MM-DD.tar.gz
```

## Features
- **Backup all extensions** to a `.tar.gz` file.
- **Restore all extensions** from a backup.
- **Manage individual backups**.
