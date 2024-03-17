# kustomize for customization of Data Mesh pattern deploymnts:

The open source utility Kustomize has a variety of uses for the modification of Kubernetes YAML files. It can be used either before a deployment to generate a new file to be applied to the cluster, or it can be used directly by the OC (or kubectl) command to apply dynamically patched resources to the cluster. Central to the use of Kustomize is the management of a kustomization.yaml file that refers to the Kubernetes resources to be deployed to the cluster. In addition to applying a set of files to the cluster with a single command, the kustomization.yaml file can contain text replacement specifications to be applied to the YAML files to which it refers.

The following are the bare minimum compoments required to build Data Mesh pattern and deploy datamesh patterb.

1. [Airflow ] (https://airflow.apache.org/)

2. [Trino ] (https://trino.io/docs/current/)

3. [MinIo ] (https://min.io/)

4. [OpenMetaData ] (https://docs.open-metadata.org/)

5. [SuperSet ] (https://superset.apache.org/)

6. [Jupyter NoteBook ] (https://jupyter.org/)


![images/deploy-structure.png](images/deploy-structure.png)

# Deployment instruction :

Note : This deployment is just for development purpose ,  not for prodction use. 

The main objectibve of Data mesh deployment is to deploy all components in few mintues by executing simple one shell scripts. 

Each data mesh compoent has it's own deployment manifest(s) on its own directory in deployment folder as shown in a above screen shot. You can deploy all Data Mesh components in one shot by execting "datamesh-deploy.sh" or you can deploy individual compoent by executing "kustomize-run.sh" which is located on it's won folder. 


```bash
git clone git@github.com:opendatahub-io-contrib/datamesh-platform.git
```bash

Navigate to Data Mesh cloned director " cd datamesh-platform/deployment and execute "datamesh-deploy.sh".
By defautt , depoyment will use datamesh-demo as default namespace in openshift. If you want to change, edit "datamesh-deploy.sh" environment  varible to your own namespace name "export NAMESPACE="datamesh-demo"

```bash
./datamesh-deploy.sh
```

