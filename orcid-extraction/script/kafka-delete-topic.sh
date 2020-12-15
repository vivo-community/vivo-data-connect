#!/bin/bash 

###################################################################
# Script Name    : kafka-delete-topic.sh
# Description    : 
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh
# List existing topics
kafka-topics.sh --delete \
  --bootstrap-server $KAFKA_HOST:9092 \
  --topic $TOPIC
  
  #  --replication-factor 1 --partitions 13 \
  
