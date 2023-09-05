#!/bin/bash

# Path to local repository
localDir="/Users/ravi/Documents/website/biosonix-local"

# Navigate to local repository
cd "$localDir"

# Build the latest version
jekyll build

# Ask user for commit message
read -p "Enter commit message: " commitMessage

# Stages all files
git add .
git commit -m "$commitMessage"

# Rebase
git pull --rebase origin gh-pages

# Push to gh-pages branch
git push origin gh-pages
