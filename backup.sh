#!/bin/bash

DIR="$1"
ALGO="$2"
OUTPUT="$3"

# Check if the directory exists
if [ ! -d "$DIR" ]; then
    echo "Error: Directory '$DIR' does not exist." >&2
    exit 1
fi

# Create the backup archive using tar and the specified compression algorithm
tar $TAR_OPTIONS "$DIR" | case $ALGO in
    none) : ;;
    gzip) gzip ;;
    bzip2) bzip2 ;;
    lzma) lzma ;;
    xz) xz ;;
    *) echo "Error: Unsupported compression algorithm '$ALGO'." >&2; exit 1 ;;
esac > "$OUTPUT.tar.$ALGO"

# Encrypt the backup archive using openssl
openssl enc -aes-256-cbc -salt -in "$OUTPUT.tar.$ALGO" -out "$OUTPUT.enc" 2>&1 | tee -a error.log

# Remove the unencrypted backup archive
rm "$OUTPUT.tar.$ALGO" 2>&1 | tee -a error.log

echo "Backup completed successfully as '$OUTPUT.enc'" | tee -a error.log
