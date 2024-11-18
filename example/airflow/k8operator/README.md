
# How to deploy airflow K8-operator and execute each task as a docker container:

# instruction :
    
Example docker image is provided in the following folder for the task that need to be run as a docker container.
        
    Docker image for Task : **example/airflow/k8operator/example-dockerimage**
    
    Dags for K8-operators : **example/airflow/k8operator/dags**

    Step 1  : build docker image 

    Step 2  : update the image to existing dag or create new k8-operator dag to the dags folder.

    step 3  : deploy the dags to airflow instnace.

