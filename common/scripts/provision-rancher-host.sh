#! /bin/bash
hostmachine=$1

echo "###### RANCHER START ######"

echo "### Install jq ###"

sudo apt-get -y install jq

echo "### Register host with rancher"

echo "Host machine is $hostmachine"

cmd=$(curl -s http://${hostmachine}:8080/v2-beta/registrationToken | jq -r .data[].command)

echo "Starting Rancher agent"
echo $cmd

$cmd

echo "###### RANCHER END ######"
