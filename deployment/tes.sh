#!/bin/bash

# Get the current working directory
current_directory=$(pwd)

# Navigate to the parent directory
parent_directory=$(dirname "$current_directory")

# Append the next directory to the current relative path
next_directory="next_directory"
next_path="$parent_directory/$next_directory"

echo "Next path: $next_path"
