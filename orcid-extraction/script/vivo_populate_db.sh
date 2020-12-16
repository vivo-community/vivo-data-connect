#!/bin/bash

###################################################################
# Script Name    : kafka-populate_vivo
# Description    : Consuming Kafka messages and transmitting them VIVO
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh
source credential.sh

UPDATE="update=LOAD <file://$ONTO_ALL_RECORDS> into graph <http://localhost:8080/vivo/graph/vivo_demo>"
curl -i -d "email=$USER" -d "password=$PASSWD" -d "$UPDATE" "$VIVO_URL/api/sparqlUpdate"
