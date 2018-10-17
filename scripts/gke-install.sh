#!/bin/bash

# Setting environment variables

export CLUSTER_NAME=idv-gke-01
export CLUSTER_ZONE=us-central1-c
export PROJECT_ID=idv-dev-project-01

# Set the default project in gcloud shell
gcloud config set project $PROJECT_ID

# Enabling the necessary APIs
gcloud services enable \
  cloudapis.googleapis.com \
  container.googleapis.com \
  containerregistry.googleapis.com
  
# Create a GKE cluster
gcloud container clusters create $CLUSTER_NAME \
  --zone=$CLUSTER_ZONE \
  --cluster-version=latest \
  --machine-type=n1-standard-4 \
  --enable-autoscaling --min-nodes=1 --max-nodes=10 \
  --enable-autorepair \
  --scopes=service-control,service-management,compute-rw,storage-ro,cloud-platform,logging-write,monitoring-write,pubsub,datastore \
  --num-nodes=3
  
# To authenticate for the cluster, run the following command:
gcloud container clusters get-credentials $CLUSTER_NAME

# Grant cluster-admin permissions to the current user:
kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole=cluster-admin \
  --user=$(gcloud config get-value core/account)
