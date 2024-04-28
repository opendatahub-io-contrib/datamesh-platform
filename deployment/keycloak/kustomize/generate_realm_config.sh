#!/bin/bash

# export REALM_NAME="KeycloakRealm"
# export NAMESPACE="datamesh-demo1"
# export HOST_URL="apps.osc-cl4.apps.os-climate.org"
export CLIENT_SECRET="QiEZ6U5enz4YGp9alJg6Cw7g87RIEk4z"


# Path to your template file
template_file="./deployment/keycloak/kustomize/realm-export-template.json"

# Path to output the final JSON file
output_file="realm-config.json"

# Replace placeholders with environment variables
# envsubst < "$template_file" > "$output_file"
sed -e "s/\${REALM_NAME}/$REALM_NAME/g" \
    -e "s/\${NAMESPACE}/$NAMESPACE/g" \
    -e "s/\${HOST_URL}/$HOST_URL/g" \
    -e "s/\${CLIENT_SECRET}/$CLIENT_SECRET/g" \
    "$template_file" > "./deployment/keycloak/kustomize/base/deployment-manifest/realm/$output_file"

