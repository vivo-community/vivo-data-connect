#!/bin/bash 

###################################################################
# Script Name    : kafka-describe-topic.sh
# Description    : 
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh
# List existing topics
kafka-topics.sh --describe \
  --bootstrap-server $KAFKA_HOST:9092 
