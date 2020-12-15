#!/usr/bin/env bash

###################################################################
# Script Name    : kafka-list-topic.sh
# Description    : 
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh
# List existing topics
kafka-topics.sh --list \
    --zookeeper $KAFKA_HOST:2181
