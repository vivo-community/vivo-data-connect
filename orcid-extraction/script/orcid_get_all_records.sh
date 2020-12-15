#!/bin/bash
###################################################################
# Script Name    : orcid_get_all_record.sh
# Description    : This script establishes a connection to ORCID and extract all informations for each UQAM's ORCID_ID 
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh
[ -d records ] || rm -rf demo || mkdir records
all_records=`$DEMO_HOME/script/orcid_search_uqam.sh` 
nbr_of_records=`echo $all_records |  xargs -n1 | wc -l`
for n in  $all_records ; do
    ((i=i+1))
    ((j=j+1))
    echo process $i/$nbr_of_records $n
    $DEMO_HOME/script/orcid_get_a_record.sh $n > $DEMO_HOME/script/records/$n.ttl &
    # Processes five elements in parallel to speed up processing
    if [ $j = "5" ]; then
    echo 'waiting...'
    wait
        ((j=0))
    fi
done
echo "Done!"