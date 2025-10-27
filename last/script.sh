#!/bin/bash

# Define the root directory (default: current directory)
ROOT_DIR="${1:-.}"

echo "=========================================="
echo "📁 INCEPTION PROJECT STRUCTURE"
echo "=========================================="
echo

# Print folder structure
# -a : show hidden files
# -I : ignore .git and build folders if any
tree -a -I ".git|build" "$ROOT_DIR"
echo
echo "=========================================="
echo "📄 FILE CONTENTS"
echo "=========================================="
echo

# Loop through all files and display content
find "$ROOT_DIR" -type f ! -path "*/.git/*" | while read -r file; do
    echo "------------------------------------------"
    echo "📄 File: $file"
    echo "------------------------------------------"
    # If file is binary, skip showing content
    if file "$file" | grep -q "text"; then
        cat "$file"
    else
        echo "(Binary file - content not displayed)"
    fi
    echo
done
