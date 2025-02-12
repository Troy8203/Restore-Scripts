#!/bin/bash

check_file() {
    local file_import=$1
    if [ ! -f "$file_import" ]; then
        echo "Error: File '$file_import' does not exist."
        return 1
    else
        echo "File '$file_import' exists."
    fi
}


check_file $1