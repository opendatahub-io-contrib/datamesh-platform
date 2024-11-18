from pendulum import datetime
from airflow import DAG
from airflow.providers.cncf.kubernetes.operators.kubernetes_pod import (
    KubernetesPodOperator,
)

with DAG(
    dag_id="pcaf_ingestion_unfccckoperator1",
    schedule="@once",
    start_date=datetime(2024, 11, 5),
) as dag:
    pcaf_ingestion_unfccckoperator1 = KubernetesPodOperator(
    namespace='datamesh-demo',
    image="quay.io/osclimate/osclimate-tek8oper-test:1.2",
    name="pcaf_ingestion_unfccc-pod1",
    image_pull_policy="Always",
    task_id="pcaf_ingestion_unfccc",
    is_delete_operator_pod=False,
    get_logs=True,
    service_account_name='airflow',
    hostnetwork=False,
    startup_timeout_seconds=1000
    )
        
    pcaf_ingestion_unfccckoperator1