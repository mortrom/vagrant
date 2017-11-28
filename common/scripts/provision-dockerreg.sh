#! /bin/bash

echo "###### DOCKER REGISTRY START ######"

echo "### Run docker registry container"

docker run \
  -d \
  -p 5000:5000 \
  --name registry registry:2

echo "###### DOCKER REGISTRY END ######"
