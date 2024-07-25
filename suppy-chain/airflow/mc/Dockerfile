
# Use the MinIO client image as the base
FROM minio/mc:latest

# Set the working directory in the container
#WORKDIR /scripts

# Create a new home directory for the MinIO client config
#RUN mkdir -p /minio-client-config

RUN mkdir -p /.mc

# Set environment variable to point to the new home directory
#ENV MC_HOME=/minio-client-config

# Copy your script into the container
#COPY ./script/minio_script.sh /scripts/
COPY ./script/minio_script.sh /usr/bin/


# Make the script executable
#RUN chmod +x minio_script.sh
RUN chmod +x /usr/bin/minio_script.sh
# Override the ENTRYPOINT
ENTRYPOINT ["/usr/bin/minio_script.sh"]
