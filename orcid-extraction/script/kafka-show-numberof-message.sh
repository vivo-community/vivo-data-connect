#!/bin/bash 

###################################################################
# Script Name    : kafka-show-numberof-message..sh
# Description    : Kafka show number of messages in a script
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh
kafka-run-class.sh kafka.tools.GetOffsetShell \
  --broker-list $KAFKA_HOST:9092 \
  --topic $TOPIC --time -1 --offsets 1  \
  | awk -F  ":" '{sum += $3} END {print sum}'