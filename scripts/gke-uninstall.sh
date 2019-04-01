#!/bin/bash

# Setting environment variables

export CLUSTER_NAME=c1
export CLUSTER_ZONE=us-east1-c

# To delete the cluster, enter the following command:

gcloud container clusters delete -q $CLUSTER_NAME --zone $CLUSTER_ZONE
