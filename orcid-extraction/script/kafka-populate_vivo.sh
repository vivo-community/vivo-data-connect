#!/bin/bash 

###################################################################
# Script Name    : kafka-populate_vivo
# Description    : Consuming Kafka messages and transmitting them VIVO
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh
ONTO_ALL_RECORDS=data.n3
i=0
rest=`kafka-show-numberof-message.sh`
while [ true ]
do
    totmess=`kafka-show-numberof-message.sh`
    rest=$[$totmess-$i]
    echo process offset = $i
    echo "There are still $rest messages to process"
    if [ $i -lt $rest ]
    then
        ./kafka-start-consumer.sh $i > $ONTO_ALL_RECORDS
        ./vivo_populate_db.sh
    else
        echo "Wating for messages in topic"
        sleep 2
    fi
    nbr=1000
    if [ $rest -lt 1000 ]
    then
        nbr=$rest
    fi
    i=$[$i+$nbr] # Populate VIVO in groups of 1000 messages or rest
done