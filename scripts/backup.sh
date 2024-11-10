#!/bin/bash

# Base backup directory
BACKUP_BASE="backups"

# Create dated subdirectories for better organization
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
DAY=$(date +"%d")
TIMESTAMP=$(date +"%H%M%S")

# Create full backup path
BACKUP_PATH="$BACKUP_BASE/$YEAR/$MONTH/$DAY"
mkdir -p $BACKUP_PATH

# Backup filename with timestamp
BACKUP_FILE="$BACKUP_PATH/face_auth_backup_$TIMESTAMP.tar.gz"

# Files/directories to exclude from backup
EXCLUDE_LIST=(
    "node_modules"
    "dist"
    "*.log"
    ".git"
    "backups"
    ".env"
)

# Build exclude string for tar
EXCLUDE_STRING=""
for item in "${EXCLUDE_LIST[@]}"; do
    EXCLUDE_STRING="$EXCLUDE_STRING --exclude='$item'"
done

echo "Starting backup process..."
echo "Backup location: $BACKUP_FILE"

# Create the backup
eval "tar -czf $BACKUP_FILE $EXCLUDE_STRING ."

# Calculate backup size
BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)

# Create a manifest file
MANIFEST_FILE="$BACKUP_PATH/backup_manifest.txt"
echo "=== Backup Manifest ===" >> "$MANIFEST_FILE"
echo "Date: $(date)" >> "$MANIFEST_FILE"
echo "Backup File: $(basename $BACKUP_FILE)" >> "$MANIFEST_FILE"
echo "Size: $BACKUP_SIZE" >> "$MANIFEST_FILE"
echo "Contents:" >> "$MANIFEST_FILE"
tar -tzf "$BACKUP_FILE" | grep -v '/$' >> "$MANIFEST_FILE"

# Cleanup old backups (keep last 30 days)
find "$BACKUP_BASE" -type f -name "*.tar.gz" -mtime +30 -exec rm {} \;

echo "Backup completed successfully!"
echo "Location: $BACKUP_FILE"
echo "Size: $BACKUP_SIZE"
echo "Manifest: $MANIFEST_FILE"

# List recent backups
echo -e "\nRecent backups:"
find "$BACKUP_BASE" -type f -name "*.tar.gz" -mtime -7 -exec ls -lh {} \;