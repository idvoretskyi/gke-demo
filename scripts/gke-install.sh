#!/bin/bash

# Setting environment variables

export CLUSTER_NAME=idv-gke-01
export CLUSTER_ZONE=us-east1-c
export PROJECT_ID=idv-dev-0

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
	--machine-type=f1-micro \
	--enable-autorepair \
	--preemptible \
	--scopes=service-control,service-management,compute-rw,storage-ro,cloud-platform,logging-write,monitoring-write,pubsub,datastore \
	--num-nodes=3

# To authenticate for the cluster, run the following command:
gcloud container clusters get-credentials $CLUSTER_NAME --zone=$CLUSTER_ZONE

# Grant cluster-admin permissions to the current user:
kubectl create clusterrolebinding cluster-admin-binding \
	--clusterrole=cluster-admin \
	--user=$(gcloud config get-value core/account)
