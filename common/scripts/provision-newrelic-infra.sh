#! /bin/bash
license_key=$1

echo "### Create new relic infrastructure config file"
echo "license_key: $license_key" | sudo tee -a /etc/newrelic-infra.yml

echo "### Retrieve and install the New Relic GPG key"
curl https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg | sudo apt-key add -

echo "### Create the infra agent apt repo"
printf "deb [arch=amd64] https://download.newrelic.com/infrastructure_agent/linux/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/newrelic-infra.list

echo "### Update the apt cache"
sudo apt-get update

echo "### Correct dependencies"
sudo apt-get -f install -y

echo "### Install the new relic infra agent"
sudo apt-get install newrelic-infra -y
