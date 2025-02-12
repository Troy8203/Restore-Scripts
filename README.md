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
curl -s https://raw.githubusercontent.com/Troy8203/Restore-Scripts/refs/heads/main/backup_extensions.sh | bash -s https://github.com/Troy8203/Restore-Scripts/raw/refs/heads/main/backup/backup_2025-02-12.tar.gz
```

## Features
- **Backup all extensions** to a `.tar.gz` file.
- **Restore all extensions** from a backup.
- **Manage individual backups**.
