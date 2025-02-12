#!/bin/bash

# Function to get the list of extensions
get_extensions() {
    local extensions=()
    mapfile -t extensions < <(dconf list /org/gnome/shell/extensions/)
    if [ ${#extensions[@]} -eq 0 ]; then
        echo "No extensions found in /org/gnome/shell/extensions/" >&2
        return 1
    fi

    # Remove trailing "/" from each extension
    for i in "${!extensions[@]}"; do
        extensions[$i]="${extensions[$i]%/}"
    done

    # Print the array elements so they can be captured by the caller
    printf "%s\n" "${extensions[@]}"
}

# Show all extensions of a folder
show_extensions_backup() {
    local folder_name="$1"
    if [ ! -d "$folder_name" ]; then
        echo "Error: Folder '$folder_name' does not exist."
        return 1
    fi

    echo "List of extensions in $folder_name:"
    for file in "$folder_name"/*; do
        echo "** ${file##*/}"
    done

    read -p "Press [Enter] key to continue..."
    clear
}

# Function to create a backup file from an extension
create_file_backup() {
    local file_ext="$1"
    local folder_name="$2"

    if [ ! -d "$folder_name" ]; then
        echo "Folder '$folder_name' does not exist. Creating it..."
        mkdir -p "$folder_name"
    fi

    echo "Creating backup for $file_ext..."
    dconf dump "/org/gnome/shell/extensions/$file_ext/" > "$folder_name/$file_ext"

    echo "Backup saved: $folder_name/$file_ext"
}

import_file_backup() {
    local file_import="$1"
    local folder_name="$2"
    
    if [ ! -f "$folder_name/$file_import" ]; then
        echo "Error: File '$folder_name/$file_import' does not exist."
        return 1
    fi

    echo "Importing backup for $file_import..."
    dconf load "/org/gnome/shell/extensions/$file_import/" < "$folder_name/$file_import"
    echo "Backup imported: $folder_name/$file_import"
}

# Function to create a file tar.gz bakcup from a folder
export_backup() {
    local folder_name="$1"
    echo "folder: ${folder_name}"
    local backup_name="${folder_name}.tar.gz"
    if [ ! -d "$folder_name" ]; then
        echo "Error: Folder '$folder_name' does not exist."
        return 1
    fi
    if [ ! -d "backup" ]; then
        mkdir -p "backup"
    fi
    tar -czvf "$backup_name" "$folder_name"
    echo "Backup created: $backup_name"
}

import_backup() {
    local file_import="$1"
    if [ ! -f "$file_import" ]; then
        echo "Error: File '$file_import' does not exist."
        return 1
    fi
    tar -xzf "$file_import"
}

# Function to export backups
export_all_backups() {
    # Display the stored extensions
    folder_backup="./backup/backup_$(date +%Y-%m-%d)"
    # Load list of extensions
    mapfile -t extensions < <(get_extensions)
    
    echo "List of extensions in /org/gnome/shell/extensions/:"
    for item in "${extensions[@]}"; do
        echo "- $item"
        create_file_backup "$item" "$folder_backup"
    done

    export_backup "$folder_backup"
    rm -rdf "$folder_backup"
}

import_all_backups() {
    local file_import=$1
    folder_backup="${file_import%.tar.gz}"

    if [ ! -f "$file_import" ]; then
        echo "Error: File '$file_import' does not exist."
        return 1
    fi
    # Load list of extensions
    mapfile -t extensions < <(get_extensions)

    # Display the stored extensions
    #import_backup "$file_import"

    #for item in "${extensions[@]}"; do
        #import_file_backup "$item" "$folder_backup"
    #done
    #rm -rdf $folder_backup
}


if [ "$#" -gt 0 ]; then
    show_extensions_backup $1
    # Call the import_all_backups function
    import_all_backups $1
else
    # Call the export_all_backups function
    export_all_backups
fi
