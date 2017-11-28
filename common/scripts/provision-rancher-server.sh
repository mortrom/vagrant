#! /bin/bash
hostmachine=$1

echo "###### RANCHER START ######"

echo "### Run Rancher in a docker container"

docker run \
  -v /vagrant/mysql:/var/lib/mysql \
  -e "CATTLE_API_HOST=http://${hostmachine}:8080" \
  -d --restart=unless-stopped \
  -p 8080:8080 \
  rancher/server:v1.6.11

echo "###### RANCHER END ######"
