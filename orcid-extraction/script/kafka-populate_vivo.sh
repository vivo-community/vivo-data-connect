#!/bin/bash 

###################################################################
# Script Name    : kafka-populate_vivo
# Description    : Consuming Kafka messages and transmitting them VIVO
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh
i=0
while [ true ]
do
    echo process offset = $i
    ./kafka-start-consumer.sh $i > ./tmp/data.n3
    ./vivo_populate_db.sh
    i=$[$i+1000]
done