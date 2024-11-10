#!/bin/bash

BACKUP_DIR="backups"

echo "Available Backups:"
echo "================="

# Function to convert bytes to human readable size
human_size() {
    local size=$1
    local units=('B' 'KB' 'MB' 'GB' 'TB')
    local unit=0
    
    while [ $size -gt 1024 ]; do
        size=$(($size/1024))
        unit=$(($unit+1))
    done
    
    echo "$size${units[$unit]}"
}

# List all backups with details
find "$BACKUP_DIR" -type f -name "*.tar.gz" | while read backup; do
    size=$(stat -f%z "$backup" 2>/dev/null || stat -c%s "$backup")
    date=$(date -r "$backup" "+%Y-%m-%d %H:%M:%S")
    echo "File: $backup"
    echo "Date: $date"
    echo "Size: $(human_size $size)"
    echo "---"
done

# Show storage statistics
total_size=$(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1)
backup_count=$(find "$BACKUP_DIR" -type f -name "*.tar.gz" | wc -l)

echo -e "\nStorage Statistics:"
echo "Total backups: $backup_count"
echo "Total size: $total_size"