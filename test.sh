#!/bin/bash
set -e

import_config_extensions() {
    local file_import=$1

    if [ -z "$file_import" ]; then
        echo "Error: No file name provided."
        exit 1
    fi

    echo "Downloading 'backup_extensions.sh'..."
    curl -s -O https://raw.githubusercontent.com/Troy8203/Restore-Scripts/trash/test-remote-bash/backup_extensions.sh
    echo "Download complete."

    chmod +x backup_extensions.sh

    mkdir backup
    echo "Downloading '$file_import'..."
    curl -s -L -o "./backup/$file_import" "https://raw.githubusercontent.com/Troy8203/Restore-Scripts/trash/test-remote-bash/backup/$file_import"
    echo "Download complete."

    echo "Executing 'backup_extensions.sh' with '$file_import'..."
    bash ./backup_extensions.sh "$file_import"
    echo "Execution complete."

    echo "Cleaning up '$file_import'..."
    #rm -f backup_extensions.sh

    echo "Process completed successfully!"
}

import_config_extensions "$1"
