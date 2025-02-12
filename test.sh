#!/bin/bash

import_config_extensions() {
    local file_import=$1

    if [ -z "$file_import" ]; then
        echo "Error: No file name provided."
        return 1
    fi

    if [ ! -f "$file_import" ]; then
        echo "Error: File '$file_import' does not exist locally."
        return 1
    fi

    echo "Downloading 'backup_extensions.sh'..."
    curl -s -O https://raw.githubusercontent.com/Troy8203/Restore-Scripts/trash/test-remote-bash/backup_extensions.sh
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download 'backup_extensions.sh'."
        return 1
    fi

    chmod +x backup_extensions.sh

    echo "Downloading '$file_import'..."
    curl -s -L -o "$file_import" "https://raw.githubusercontent.com/Troy8203/Restore-Scripts/trash/test-remote-bash/backup/$file_import"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download '$file_import'."
        return 1
    fi

    echo "Executing 'backup_extensions.sh' with '$file_import'..."
    bash backup_extensions.sh "$file_import"
    if [ $? -ne 0 ]; then
        echo "Error: Execution of 'backup_extensions.sh' failed."
        return 1
    fi

    echo "Cleaning up '$file_import'..."
    rm -f "$file_import"

    echo "Process completed successfully!"
}

import_config_extensions "$1"
