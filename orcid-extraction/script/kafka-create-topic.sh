#!/bin/bash 

###################################################################
# Script Name    : kafka-create-topic.sh
# Description    : 
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh
# List existing topics
kafka-topics.sh --create \
  --bootstrap-server $KAFKA_HOST:9092 \
  --replication-factor 1 --partitions 1 \
  --topic $TOPIC
