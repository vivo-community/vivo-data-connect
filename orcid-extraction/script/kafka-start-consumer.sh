#!/usr/bin/env bash

###################################################################
# Script Name    : kafka-start-consumer.sh
# Description    : Consume messages from the topic
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################



source environment.sh
# List existing topics
if [ -z $1 ]; 
then 
    offset='latest'; 
else 
    offset=$1;
fi
kafka-console-consumer.sh \
    --topic $TOPIC \
    --max-messages 1000 \
    --bootstrap-server $KAFKA_HOST:9092 \
    --partition 0 \
    --offset $offset

    
