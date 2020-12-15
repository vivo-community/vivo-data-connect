#!/bin/bash

###################################################################
# Script Name    : kafka-start
# Description    : 
# Args           : 
# Author         : Michel Héon
# Email          : heon.michel@uqam.ca
###################################################################

source environment.sh

sudo systemctl daemon-reload
sudo systemctl enable --now zookeeper
sudo systemctl enable --now kafka
sudo systemctl status kafka zookeeper
