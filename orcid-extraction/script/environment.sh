#!bin/bash

###################################################################
# Script Name    : environement.sh
# Description    : file containing the definition of the environment variables of the scripts. 
# Args           :
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

#
# Authorization key required to communicate with VIVO
# See also https://wiki.lyrasis.org/display/VIVO/ORCID+useful+information 
# For more information
#
ORCID_KEY="Authorization: Bearer YOUR-Bearer-KEY"


GIT_VIVO='ROOT_GIT_DIRECTORY ex.: ~/git'
DEMO_HOME=$GIT_VIVO/vivo-data-connect/orcid-extraction/script
VIVO_HOME=http://localhost:8080/vivo
JENA_HOME=/opt/jena
ORCID_VOC_IRI=http://uqam.ca/vivo-dataconnect/orcid
ONTO_UQAM=$DEMO_HOME/onto_uqam.n3

# KAFKA Variables
KAFKA_HOST=localhost
KAFKA_HOME=/opt/kafka
TOPIC=vivo-dataconnect

##### SUPPRIMER
source ~/.config/orcid_id 
GIT_VIVO=~/00-PROJECT-UQAM-VIVO/00-GIT
DEMO_HOME=/home/heon/git/vivo-data-connect/orcid-extraction
#####

PATH=$PATH:$JENA_HOME/bin:$KAFKA_HOME/bin
