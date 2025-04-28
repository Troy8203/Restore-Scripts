# GNOME Extensions Backup & Restore Script

This script backs up and restores GNOME Shell extensions using `dconf`.


![gnome](https://img.shields.io/badge/gnome-232323?style=for-the-badge&logo=gnome&logoColor=4A86CF)
![bash](https://img.shields.io/badge/BASH-232323?style=for-the-badge&logo=gnubash&logoColor=4EAA25)

## Usage

### Run Locally

#### Backup all extensions
Create a backup file of your configuration with the current timestamp:

```sh
git clone https://github.com/Troy8203/Restore-Scripts.git
cd Restore-Scripts
./backup-extensions.sh
```
> It uses the path `/org/gnome/shell/extensions/` as a reference.

#### Restore from a backup
Restore a backup from a specified file:

```sh
./backup-extensions.sh ./backup/backup_YYYY-MM-DD.tar.gz
```
> The backup file must be located in the `backup` folder.

### Run with `curl`

#### Create a backup file

You can create a backup of your configuration with a single command:

```sh
curl -s https://raw.githubusercontent.com/Troy8203/Restore-Scripts/develop/backup-extensions.sh | bash
```

#### Restore a backup from the cloud

Restore a backup file hosted in the repository:

```sh
curl -s https://raw.githubusercontent.com/Troy8203/Restore-Scripts/develop/test.sh | bash -s <file>
```

Example:

```sh
curl -s https://raw.githubusercontent.com/Troy8203/Restore-Scripts/develop/test.sh | bash -s backup_2025-02-12.tar.gz
```
> Note: The file must already be uploaded to the repository.

## Features

- Backup all GNOME extensions to a `.tar.gz` file.
- Restore all GNOME extensions from a backup file.
- Manage individual backups easily.