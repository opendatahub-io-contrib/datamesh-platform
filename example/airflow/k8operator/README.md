# Example for how deploy airflow K8-operator run airflow task as a container:


# instruction :
    Example docker image is provided in the following folder.
        
        Docker image for Task : **example/airflow/k8operator/example-dockerimage**
    
        Dags for K8-operators : **example/airflow/k8operator/dags**

    Step 1  : build docker image 

    Step 2  : update the image to existing dag or create new k8-operator dag to the dags folder.

    step 3  : deploy the dags to airflow instnace.

