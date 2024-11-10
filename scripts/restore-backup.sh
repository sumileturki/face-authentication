#!/bin/bash

BACKUP_DIR="backups"

# List available backups
echo "Available backups:"
echo "================="

# Create array of backup files
mapfile -t backups < <(find "$BACKUP_DIR" -type f -name "*.tar.gz" | sort -r)

# Display backups with numbers
for i in "${!backups[@]}"; do
    echo "[$i] ${backups[$i]}"
done

# Get user selection
read -p "Enter the number of the backup to restore: " selection

if [[ $selection =~ ^[0-9]+$ ]] && [ "$selection" -lt "${#backups[@]}" ]; then
    selected_backup="${backups[$selection]}"
    
    echo "You selected: $selected_backup"
    read -p "Are you sure you want to restore this backup? (y/n): " confirm
    
    if [ "$confirm" = "y" ]; then
        # Create restore directory
        RESTORE_DIR="restore_$(date +%Y%m%d_%H%M%S)"
        mkdir "$RESTORE_DIR"
        
        echo "Restoring backup to $RESTORE_DIR..."
        tar -xzf "$selected_backup" -C "$RESTORE_DIR"
        
        echo "Backup restored successfully to $RESTORE_DIR"
        echo "Please review the contents before replacing your current files"
    else
        echo "Restore cancelled"
    fi
else
    echo "Invalid selection"
fi