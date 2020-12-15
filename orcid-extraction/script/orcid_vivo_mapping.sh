#!/bin/bash

###################################################################
# Script Name    : orcid_vivo_mapping.sh
# Description    : Mapping ORCID RDF data to VIVO vocabulary. Results are in n3 format for transmission to Kafka. 
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh
cd records
echo "" > $ONTO_ALL_RECORDS 

for n in *.ttl ; do
    ((i=i+1))
    ((j=j+1))
    bn=`basename $n .ttl`
    echo process $i $bn
    (sparql --data=$n  --query=../sparql/get_name.sparql --results=N-Triples > ${bn}_name.n3 ; cat ${bn}_name.n3 >> $ONTO_ALL_RECORDS) &  
    (sparql --data=$n  --query=../sparql/get_org.sparql --results=N-Triples > ${bn}_org.n3; cat ${bn}_org.n3 >> $ONTO_ALL_RECORDS) &
    (sparql --data=$n  --query=../sparql/get_comp.sparql --results=N-Triples > ${bn}_comp.n3 ; cat ${bn}_comp.n3 >> $ONTO_ALL_RECORDS) &
    sleep 1  # The sleep is to distribute the CPU load.
    if [ $j = "5" ]; then
    echo 'waiting...'
    wait
    ((j=0))
    fi
done
echo "Done!"
