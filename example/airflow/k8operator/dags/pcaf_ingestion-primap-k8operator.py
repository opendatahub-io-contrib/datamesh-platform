from pendulum import datetime
from airflow import DAG
from airflow.providers.cncf.kubernetes.operators.kubernetes_pod import (
    KubernetesPodOperator,
)

with DAG(
    dag_id="pcaf_ingestion_primapkoperator1",
    schedule="@once",
    start_date=datetime(2024, 11, 5),
) as dag:
    pcaf_ingestion_primapkoperator1 = KubernetesPodOperator(
        namespace='datamesh-demo',
        image="quay.io/osclimate/osclimate-tek8oper-test:1.1",
        name="ingestion-primap-pod7",
        task_id="ingestion-primap",
        is_delete_operator_pod=False,
        get_logs=True,
        service_account_name='airflow',
        hostnetwork=False,
        startup_timeout_seconds=1000
    )

    pcaf_ingestion_primapkoperator1
