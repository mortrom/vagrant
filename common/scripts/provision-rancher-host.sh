#! /bin/bash
hostmachine=$1
port=${2:-8080}

RETRY_COUNT=1000
rc=0

function get_start_cmd() {
  local hostmachine=$1
  local port=$2
  local project_id=$3
  echo $(curl -s http://${hostmachine}:${port}/v1/registrationtokens?projectId=$project_id | jq -r .data[].command)
}

echo "###### RANCHER START ######"

echo "### Install jq ###"

sudo apt-get -y install jq

echo "### Register host with rancher"

echo "### Host machine is $hostmachine"

echo "### Extracting agent start command."

project_id=$(curl -s http://${hostmachine}:${port}/v1/projects | jq -r ".data[0].id")
echo "### project id is $project_id"

echo "### Check if the start command is available"
cmd=$(get_start_cmd "$hostmachine" "$port" "$project_id")
if [[ -z $cmd ]]
then
  echo "### Start command unavailable, registering."
  # The following generates the registration token for the command extraction
  registration=$(curl -s -X POST http://${hostmachine}:${port}/v1/registrationtokens?projectId=$project_id)
  echo "### Registration response is $registration"
  for (( i = 0; i < $RETRY_COUNT; i++ )); do
    cmd=$(get_start_cmd "$hostmachine" "$port" "$project_id")
    if [[ -z "$cmd" ]]
    then
      echo "### Agent start command not available. waiting 10 seconds."
      sleep 10
    else
      echo "### Found agent start command."
      echo $cmd
      break
    fi
  done
else
  echo "### Agent start command retrieved."
  echo $cmd
fi

if [[ $RETRY_COUNT == $i ]]
then
  echo "### Timed out waiting for start command."
  rc=1
else
  echo "### Starting Rancher agent"
  $cmd
  rc=$?
fi

echo "###### RANCHER END ######"
exit $rc
