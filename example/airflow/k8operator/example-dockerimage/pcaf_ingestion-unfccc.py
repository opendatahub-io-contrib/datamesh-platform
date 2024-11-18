import requests
import pendulum
import os.path
import urllib.request
from sqlalchemy import create_engine, text

import boto3
import pandas as pd
from io import BytesIO
from zipfile import ZipFile


def load_data_to_s3_bucket():
    
    url = "https://zenodo.org/records/8159736/files/parquet-only.zip"
    local_file = "parquet-only.zip"
    if os.path.isfile(local_file):
            os.remove(local_file)   

    if not os.path.isfile(local_file):
        with urllib.request.urlopen(url) as file:
            with open(local_file, "wb") as new_file:
                new_file.write(file.read())
            new_file.close()

    zipfile = zipfile.ZipFile(open(local_file, "rb"))

    # Initialize the MinIO client using boto3
    s3_client = boto3.client(
        's3',
        endpoint_url='http://minio:8080',  # Replace with your MinIO server URL
        aws_access_key_id='minioAdmin',
        aws_secret_access_key='minio1234',
        region_name='us-east-1'  # Optional; can be None if MinIO doesn't require it
    )

    # Path to your local ZIP file containing Parquet files
    # zip_file_path = "https://zenodo.org/records/8159736/files/parquet-only.zip"
    bucket_name = "pcaf"

    # Open the ZIP file and process each Parquet file inside
    with ZipFile(zipfile, 'r') as zipfile:
        for parquet_file_name in zipfile.namelist():
            with zipfile.open(parquet_file_name, "r") as file_descriptor:
                # Load Parquet file into DataFrame
                df = pd.read_parquet(file_descriptor)
                # Convert DataFrame to Parquet bytes with GZIP compression
                parquet_bytes = df.to_parquet(compression='gzip')
                data_stream = BytesIO(parquet_bytes)  # Convert to a stream for upload

                # Upload to MinIO
                s3_client.upload_fileobj(
                    Fileobj=data_stream,
                    Bucket=bucket_name,
                    Key=f'raw/unfccc/{parquet_file_name.lower()}'
                )
                print(f"Uploaded {parquet_file_name.lower()} to MinIO")

        print("zip files uploaded to minnio successfully.")

        
    
    host = "trino"
    port = 8080
    username = "admin"
    catalog = "hive"  # e.g., "hive"


    # Create the SQLAlchemy engine for Trino
    # engine = create_engine(f"trino://{username}@{host}:{port}/{catalog}/{schema}?protocol=https")
    engine = create_engine(f"trino://{username}@{host}:{port}/{catalog}/?protocol=http")
    print("trino connection success")
    # CREATE SCHEMA IF NOT EXISTS hive.pcaf WITH (location = 's3a://pcaf/data'
    # Create a schema (if needed)
    schema_name = "pcaf"
    location= "s3a://pcaf/data"

    create_schema_query = f"""CREATE SCHEMA IF NOT EXISTS {schema_name} WITH (location = '{location}')"""
    print("Initiated--2 ")
    
    with engine.connect() as connection:
        connection.execute(text(create_schema_query))

        print(f"Schema '{schema_name}' created with location '{location}' or already exists.")

    table_name = "annexi"
    external_location = "s3a://pcaf/raw/unfccc/data/annexi"
    
    sql_table =f"""CREATE TABLE IF NOT EXISTS {schema_name}.{table_name} (
                    party varchar,
                    category varchar,
                    classification varchar,
                    measure varchar,
                    gas varchar,
                    unit varchar,
                    year varchar,
                    numberValue double,
                    stringValue varchar
                    )
                    with (
                     external_location = '{external_location}',
                     format = 'PARQUET'
                    )"""
    
    with engine.connect() as connection:
        connection.execute(text(sql_table))
        
    table_name_non_annexi = "non_annexi"
    non_annexi_location = "s3a://pcaf/raw/unfccc/data/non-annexi"

    sql_non_annexi=f"""CREATE TABLE IF NOT EXISTS  {schema_name}.{table_name_non_annexi} (
            party varchar,
            category varchar,
            classification varchar,
            measure varchar,
            gas varchar,
            unit varchar,
            year varchar,
            numberValue double,
            stringValue varchar
            )
            with (
                external_location = '{non_annexi_location}',
                format = 'PARQUET'
            )"""
            
    with engine.connect() as connection:
        connection.execute(text(sql_non_annexi))
        
    
    load_data_to_s3_bucket()
