#!/bin/bash

chmod +x kustomize-build.sh

OC_TOKEN="--token=sha256~ZWqVO_9d1zUaETj5fku0HGq5IQNAyCyE6e3_OMpK5_w --server=https://api.osc-cl4.apps.os-climate.org:6443"

# Set variables for OCP cluster connection
OCP_SERVER="https://api.your.ocp.cluster.com:6443"
OCP_USERNAME="your_username"
OCP_PASSWORD="your_password"

#OCP_CONNECTON = "$OCP_USERNAME" -p "$OCP_PASSWORD" "$OCP_SERVER"
# Login to the OCP cluster

if [ -n "$OC_TOKEN" ]; then
    echo "connecting openshift using token."
    oc login --token=sha256~w2qOfkLErFjbh3A6oqFWpfSL7ofiZl4Jbs9PsTCHV78 --server=https://api.osc-cl4.apps.os-climate.org:6443

else
    echo "connecting openshfit using user id & password ."
    # oc login -u "$OCP_USERNAME" -p "$OCP_PASSWORD" "$OCP_SERVER"

fi

# Run kustomize 

./kustomize-build.sh 
