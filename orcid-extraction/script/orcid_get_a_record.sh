#!/bin/bash

###################################################################
# Script Name    : orcid_get_a_record.sh
# Description    : This script establishes a connection to ORCID and looks for the record associated with an ID 
# Args           : ORCID_ID
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh

ID=$1
response=$(curl -s -H "Accept: application/vnd.orcid+json"  -H "$ORCID_KEY" "https://pub.orcid.org/v3.0/$ID/record")
echo $response | $DEMO_HOME/script/json2rdf.sh  | cat $DEMO_HOME/script/data/orcibMemberHeader.ttl - | sed 's/ORCIDID/'"$ID"'/g'