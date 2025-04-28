#!/bin/bash

current_version="0.1.0"

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

# Function to create a backup file from an extension
create_file_backup() {
    local file_ext="$1"
    local folder_name="$2"

    if [ ! -d "$folder_name" ]; then
        echo -e "Folder '$folder_name' does not exist.\nCreating it..."
        mkdir -p "$folder_name"
    fi

    echo -e "\tCreating backup for $file_ext..."
    dconf dump "/org/gnome/shell/extensions/$file_ext/" > "$folder_name/$file_ext"

    echo -e "\tBackup saved: $folder_name/$file_ext"
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
    #echo "folder: ${folder_name}"
    local backup_name="${folder_name}.tar.gz"
    if [ ! -d "$folder_name" ]; then
        echo "Error: Folder '$folder_name' does not exist."
        return 1
    fi
    if [ ! -d "backup" ]; then
        mkdir -p "backup"
    fi
    #tar -czvf "$backup_name" "$folder_name" #Display the stored extensions
    tar -czf "$backup_name" "$folder_name"
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
    #Show the list of extensions
    list_extensions_from_file "$file_import"

    # Load list of extensions
    mapfile -t extensions < <(get_extensions)

    # Display the stored extensions
    import_backup "$file_import"

    #show_extensions_backup "$folder_backup"

    for item in "${extensions[@]}"; do
        import_file_backup "$item" "$folder_backup"
    done
    rm -rdf $folder_backup
}

help() {
    echo "Usage:"
    echo -e "\t backup_extensions.sh [-h | --help] [-v | --version] [-l | --list][file_import]"
    echo "Options:"
    echo -e "\t -h, --help\t\t\t Display this help message."
    echo -e "\t -v, --version\t\t\t Display the version number."
    echo -e "\t -l, --list\t\t\t List all extensions."
    echo "Arguments:"
    echo -e "\t file_import\t\t\t Restore from a backup file."
    echo -e "\t -l --list file_import\t\t\t Display the list of extensions from a backup file."
}

version() {
    echo "v$current_version"
}

list_extensions() {
    echo "List of extensions in /org/gnome/shell/extensions/:"
    dconf list /org/gnome/shell/extensions/ | less
}

list_extensions_from_file() {
    local file_import=$1
    folder_backup="${file_import%.tar.gz}"
    echo "List of extensions in $folder_backup:"
    if [ ! -f "$file_import" ]; then
        echo "Error: File '$file_import' does not exist."
        return 1
    fi
    tar -tzf $file_import | grep -v '/$' | sed 's|.*/||' | sed 's/^/- /' | less
}


if [ "$#" -gt 2 ]; then
    echo "Error: Too many arguments provided."
    echo "Usage: backup_extensions.sh [-h | --help] [-v | --version] [-l | --list][file_import]"
    exit 1
fi

if [ "$#" -ge 1 ]; then
    case "$1" in
        -h|--help)
            help
            exit 0
            ;;
        -v|--version)
            version
            exit 0
            ;;
        -l|--list)
            if [ "$#" -eq 2 ]; then
                list_extensions_from_file "$2"
            else
                list_extensions
            fi
            exit 0
            ;;
        *)
            import_all_backups "$1"
            exit 0
            ;;
    esac
else
    export_all_backups
fi

