#!/bin/bash 

###################################################################
# Script Name    : kafka-number_of_message
# Description    : 
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh

kafka-run-class.sh kafka.admin.ConsumerGroupCommand \
    --bootstrap-server $KAFKA_HOST:9092 \
    --all-groups \
    --describe
