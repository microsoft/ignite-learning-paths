#!/bin/bash

#0 - load parameters
source ./params.sh

az vmss list-instances --name $SCALE_SET_NAME -g $RESOURCE_GROUP -o table

sleep 5s

for i in {1..100};
do
    az storage message put -q $QUEUE_NAME --content 'Hello Ignite The Tour' --account-name $STORAGE_ACC_NAME --account-key $STORAGE_ACC_KEY
done

sleep 5s
az vmss list-instances --name $SCALE_SET_NAME -g $RESOURCE_GROUP -o table