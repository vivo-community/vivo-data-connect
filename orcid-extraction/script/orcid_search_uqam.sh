#!/bin/bash

###################################################################
# Script Name    : orcid_search_uqam.sh
# Description    : Search all ORCID_IDs of UQAM members 
# Args           :
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh
#
# Get values from ORCID in JSON of "Université du Québec à Montréal" members
#
response=$(curl -s -H "Accept: application/vnd.orcid+json"  -H "$ORCID_KEY" 'https://pub.orcid.org/v3.0/search/?q=%22Universit%C3%A9%20du%20Qu%C3%A9bec%20%C3%A0%20Montr%C3%A9al%22%0A')
#
# Process values list ( json 2 triples & extract id's from triples)
#
echo $response | $DEMO_HOME/script/json2ntriples.sh | grep ${ORCID_VOC_IRI}#path | cut -d ' ' -f 3 | tr -d '"'