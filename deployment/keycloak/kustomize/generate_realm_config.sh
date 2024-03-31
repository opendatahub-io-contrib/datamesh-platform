#!/bin/bash

export REALM_NAME="KeycloakRealm"
export NAMESPACE="datamesh-demo2"
export HOST_URL="apps.osc-cl4.apps.os-climate.org"


# Path to your template file
template_file="realm-export-template.json"

# Path to output the final JSON file
output_file="realm-config.json"

# Replace placeholders with environment variables
# envsubst < "$template_file" > "$output_file"
sed -e "s/\${REALM_NAME}/$REALM_NAME/g" \
    -e "s/\${NAMESPACE}/$NAMESPACE/g" \
    -e "s/\${HOST_URL}/$HOST_URL/g" \
    "$template_file" > "./base/deployment-manifest/realm/$output_file"

