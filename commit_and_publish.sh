#!/bin/bash

# Path to local repository
localDir = "/Users/ravi/Documents/website/echolocation-local"

# Navigate to local repository
cd "$localDir"

# Stages all files
git add .
git commit -m "latest update"

# Push to gh-pages branch
git push origin gh-pages