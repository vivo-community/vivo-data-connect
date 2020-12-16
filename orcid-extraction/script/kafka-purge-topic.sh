#!/bin/bash 

###################################################################
# Script Name    : kafka-purge-topic.sh
# Description    : Kafka topic purging script
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh
# List existing topics
kafka-topics.sh --delete \
  --bootstrap-server $KAFKA_HOST:9092 \
  --topic $TOPIC

kafka-topics.sh --create \
  --bootstrap-server $KAFKA_HOST:9092 \
  --replication-factor 1 --partitions 1 \
  --topic $TOPIC

  kafka-topics.sh --describe \
  --bootstrap-server $KAFKA_HOST:9092 
  
kafka-run-class.sh kafka.tools.GetOffsetShell \
  --broker-list $KAFKA_HOST:9092 \
  --topic $TOPIC --time -1 --offsets 1 \
  | awk -F  ":" '{sum += $3} END {print sum}'