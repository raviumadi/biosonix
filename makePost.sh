#!/bin/bash

echo "Enter the title of the file:"
read title

# Remove spaces and replace with hyphens
formatted_title=$(echo "$title" | tr ' ' '-')

# Get current date in YYYY-MM-DD format
current_date=$(date +'%Y-%m-%d')

# Construct the filename
filename="$current_date-$formatted_title.md"

# Specify the target directory
target_directory="/Users/ravi/Documents/website/biosonix-local/_posts"

# Create the .md file with the constructed filename
touch "$target_directory/$filename"

echo "File created: $filename"
