#!/bin/bash

chmod +x kustomize-build.sh

OC_TOKEN="${OCP_TOKEN:-datamesh-demo}"
NAMESPACE="${NAMESPACE:-datamesh-demo}"

# Set variables for OCP cluster connection
OCP_SERVER="${OCP_SERVER:-https://api.your.ocp.cluster.com:6443}"
OCP_USERNAME="${OCP_USERNAME:-username}"
OCP_PASSWORD="${OCP_PASSWORD:-password}"

# Login to the OCP cluster

if [ -n "$OC_TOKEN" ]; then
    echo "connecting openshift using token."
    oc login "$OC_TOKEN"
else
    echo "connecting openshfit using user id & password ."
    oc login -u "$OCP_USERNAME" -p "$OCP_PASSWORD" "$OCP_SERVER"

fi

# run kustomize to upate namespace from env

kustomize edit set namespace "$NAMESPACE"

# Run kustomize build

./kustomize-build.sh 

# add securiy context for anyuid
oc adm policy add-scc-to-user anyuid -z trino-default