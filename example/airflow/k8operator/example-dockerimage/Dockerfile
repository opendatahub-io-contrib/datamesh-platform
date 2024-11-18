# Use an official Python base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install the Trino client and pandas
RUN pip install --no-cache-dir trino[sqlalchemy]  pandas 
RUN pip install --no-cache-dir pendulum 
RUN pip install --no-cache-dir boto3


# Copy the script to the container
COPY trino_client1.py /app/trino_client1.py
COPY pcaf_ingestion-unfccc.py /app/pcaf_ingestion-unfccc.py

# Set the working directory
WORKDIR /app

# Run the script
CMD ["python", "pcaf_ingestion-unfccc.py"]
