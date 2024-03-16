#!/bin/bash

export NAMESPACE="mydatamesh-demo"

echo "Name space used for this deployment :  $NAMESPACE"
# Get the current working directory
current_directory=$(pwd)

# Navigate to the parent directory
parent_directory=$(dirname "$current_directory")

# Append the next directory to the current relative path
# next_directory="deployment/common/kustomize"
# next_path="$parent_directory/$next_directory"
# echo "Next path: $next_path"
# cd "$next_path"



directories=(
    "$parent_directory/deployment/common/kustomize"
    "$parent_directory/deployment/minio/kustomize"
    "$parent_directory/deployment/airflow/kustomize"
    "$parent_directory/deployment/trino/kustomize"
    "$parent_directory/deployment/openmetadata/kustomize"
    "$parent_directory/deployment/superset/kustomize"
    "$parent_directory/deployment/jupiternotebook/kustomize"

)

# Loop through each directory
for directory in "${directories[@]}"; do
    # Check if the directory exists
    if [ -d "$directory" ]; then
        echo "Entering directory: $directory"
        # Change to the directory
        cd "$directory" || exit
        # Loop through .sh files and execute them
        # for file in *.sh; do
        #     echo "Executing script: $file"
        #     ./"$file"
        # done
        ./kustomize-run.sh
        echo "Returning to the original directory"
        # Return to the original directory
        cd - >/dev/null || exit
    else
        echo "Directory not found: $directory"
    fi
done

