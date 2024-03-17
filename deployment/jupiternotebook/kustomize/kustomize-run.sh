#!/bin/bash

chmod +x kustomize-build.sh

OC_TOKEN="${OCP_TOKEN:-datamesh-demo}"

# Set variables for OCP cluster connection
OCP_SERVER="https://api.your.ocp.cluster.com:6443"
OCP_USERNAME="your_username"
OCP_PASSWORD="your_password"

#OCP_CONNECTON = "$OCP_USERNAME" -p "$OCP_PASSWORD" "$OCP_SERVER"
# Login to the OCP cluster

if [ -n "$OC_TOKEN" ]; then
    echo "connecting openshift using token."
    oc login "$OC_TOKEN"

else
    echo "connecting openshfit using user id & password ."
    # oc login -u "$OCP_USERNAME" -p "$OCP_PASSWORD" "$OCP_SERVER"

fi

# Run kustomize 

./kustomize-build.sh 
