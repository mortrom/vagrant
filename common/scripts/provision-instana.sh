#! /bin/bash
instana_key=$1
instana_host=${2:=saas-us-west-2.instana.io}

sudo docker run \
  --name instana-agent \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume /dev:/dev \
  --volume /sys:/sys \
  --volume /var/log:/var/log \
  --privileged \
  --net=host \
  --pid=host \
  --ipc=host \
  --env INSTANA_PORT=443 \
  --env INSTANA_HOST=$instana_host \
  --env INSTANA_KEY=$instana_key \
  instana/agent
