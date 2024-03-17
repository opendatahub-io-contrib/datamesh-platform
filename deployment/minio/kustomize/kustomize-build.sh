#!/bin/bash

NAMESPACE="${NAMESPACE:-datamesh-demo}"

chmod +x ./overlays/development

# Define the path to your kustomization directory
KUSTOMIZE_DIR="./overlays/development"


echo "name space  $NAMESPACE ."
# Navigate to the kustomization directory
cd "$KUSTOMIZE_DIR" || exit

# chmod +x "$KUSTOMIZE_DIR"

# Check if the project exists
if oc get project "$NAMESPACE" >/dev/null 2>&1; then
    echo "Project $NAMESPACE exists."
    oc project "$NAMESPACE" 

else
    echo "Project $NAMESPACE does not exist. Creating..."
    oc new-project "$NAMESPACE"
    oc project "$NAMESPACE"
    echo "Project $NAMESPACE created."
fi

# Switch to the project
#oc project "$PROJECT_NAME"
# Run kustomize command
# kustomize build .
oc apply -k .
