#!/bin/bash

chmod +x kustomize-build.sh

# OC_TOKEN="--token=sha256~4ZWU5DBK8eFQv5E1vtkyA2F6TEk9rmnkxu8NU0cR6JA --server=https://api.osc-cl4.apps.os-climate.org:6443"
OC_TOKEN="${OCP_TOKEN:-datamesh-demo}"
NAMESPACE="${NAMESPACE:-datamesh-demo}"

# Set variables for OCP cluster connection
OCP_SERVER="https://api.your.ocp.cluster.com:6443"
OCP_USERNAME="your_username"
OCP_PASSWORD="your_password"

#OCP_CONNECTON = "$OCP_USERNAME" -p "$OCP_PASSWORD" "$OCP_SERVER"
# Login to the OCP cluster

if [ -n "$OC_TOKEN" ]; then
    echo "connecting openshift using token."
    # oc login --token=sha256~czqMpWeElipLLfnVUBbo4z6zWaaJHKBBkLggrnBGicg --server=https://api.osc-cl4.apps.os-climate.org:6443
    oc login "$OC_TOKEN"
else
    echo "connecting openshfit using user id & password ."
    # oc login -u "$OCP_USERNAME" -p "$OCP_PASSWORD" "$OCP_SERVER"

fi


# run kustomize to upate namespace from env
kustomize edit set namespace "$NAMESPACE"
# Run kustomize build

./kustomize-build.sh 

oc adm policy add-scc-to-user anyuid -z trino-default