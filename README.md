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
./backup-extensions.sh ./backup/backup_YYYY-MM-DD.tar.gz
```

### Run with `curl`
Backup:
```sh
curl -s https://raw.githubusercontent.com/Troy8203/Restore-Scripts/refs/heads/main/backup_extensions.sh | bash
```
Restore:
```sh
curl -L -o backup_2025-02-12.tar.gz https://github.com/Troy8203/Restore-Scripts/raw/main/backup/backup_2025-02-12.tar.gz && \
curl -s https://raw.githubusercontent.com/Troy8203/Restore-Scripts/main/backup_extensions.sh backup_2025-02-12.tar.gz | bash
```

## Features
- **Backup all extensions** to a `.tar.gz` file.
- **Restore all extensions** from a backup.
- **Manage individual backups**.
