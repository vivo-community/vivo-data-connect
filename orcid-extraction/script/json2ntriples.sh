#!/bin/bash

###################################################################
# Script Name    : json2ntriples.sh
# Description    : Script to transform a JSON document into RDF in N-triples
# Dependency     : Installing Jena (riot)
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################


source environment.sh
cat $1 | java -jar $DEMO_HOME/lib/json2rdf.jar $ORCID_VOC_IRI | riot --formatted=N-Triples
