#!/bin/bash

###################################################################
# Script Name    : kafka-stop.sh
# Description    : Stop Kafka
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh

sudo systemctl daemon-reload
sudo systemctl disable --now kafka
sudo systemctl disable --now zookeeper
sudo systemctl status kafka zookeeper
