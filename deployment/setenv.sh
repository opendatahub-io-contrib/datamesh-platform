# Read property file
while IFS='=' read -r key value; do
    # Ignore comments and empty lines
    if [[ ! $key =~ ^\s*# && -n $key ]]; then
        # Trim leading/trailing whitespace from key and value
        key=$(echo $key | sed 's/^[ \t]*//;s/[ \t]*$//')
        value=$(echo $value | sed 's/^[ \t]*//;s/[ \t]*$//')
        # Assign value to environment variable
        export "$key"="$value"
    fi
done < config.properties

# Example usage

echo "Name Space    : $NAMESPACE"
echo "server Url    : $OCP_SERVER"
echo "token         : $OCP_TOKEN"
echo "user name     : $OCP_USERNAME"
echo "password      : $OCP_PASSWORD"
