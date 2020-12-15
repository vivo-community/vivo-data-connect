#!/usr/bin/env bash

###################################################################
# Script Name    : kafka-start-producer.sh
# Description    : 
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh
# List existing topics
kafka-console-producer.sh \
    --topic $TOPIC \
    --bootstrap-server $KAFKA_HOST:9092
