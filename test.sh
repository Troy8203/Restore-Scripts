#!/bin/bash

import_config_extensions() {
    local file_import=$1
    if [ ! -f "$file_import" ]; then
        echo "Error: File '$file_import' does not exist."
        return 1
    fi

    curl -O https://raw.githubusercontent.com/Troy8203/Restore-Scripts/trash/test-remote-bash/backup_extensions.sh && \
    curl -L -o temp_file https://raw.githubusercontent.com/Troy8203/Restore-Scripts/main/backup/$file_import && \
    mv temp_file $file_import && \
    bash backup_extensions.sh $file_import
    rm -rdf $file_import
}


import_config_extensions $1