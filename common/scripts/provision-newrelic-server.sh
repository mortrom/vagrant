#! /bin/bash

echo "###### NEW RELIC START ######"

echo "### Configure New Relic apt repo"
echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | tee /etc/apt/sources.list.d/newrelic.list

echo "### Get the new relic GPG key"
wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -

echo "### Update the local package list"
apt-get update

echo "### Install newrelic server"
apt-get install newrelic-sysmond

echo "### Configure the new relic license key"
nrsysmond-config --set license_key=feeaa097e138d001c926358f59546c8a328398bd

echo "### Add newrelic user to docker group"
usermod -a -G docker newrelic

echo "### Restart docker"
service docker restart

echo "### Start the new relic server"
systemctl start newrelic-sysmond

echo "###### NEW RELIC END ######"
