#!/bin/bash

# Setting environment variables

export CLUSTER_NAME=idv-gke-01
export CLUSTER_ZONE=us-east1-c
export PROJECT_ID=idv-dev-0

# Set the default project in gcloud shell
gcloud config set project $PROJECT_ID

# To delete the cluster, enter the following command (removing '#' before):

gcloud container clusters delete $CLUSTER_NAME --zone $CLUSTER_ZONE
