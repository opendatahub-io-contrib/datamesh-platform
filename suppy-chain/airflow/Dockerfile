FROM apache/airflow:2.9.3-python3.10
USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
         vim \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
#ADD requirements.txt . 
USER airflow

RUN pip install --no-cache-dir apache-airflow-providers-trino \
                openmetadata-managed-apis~=1.4.1 \
                openmetadata-ingestion==1.4.1 \
                astronomer-cosmos==1.2.5 \
                typing-extensions==4.5.0 \
                dbt-artifacts-parser

RUN mkdir -p /opt/airflow/dag_generated_configs

ENV AIRFLOW__CORE__DAGBAG_IMPORT_TIMEOUT="120.0"
