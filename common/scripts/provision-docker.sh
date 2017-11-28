#! /bin/bash 

echo "###### DOCKER START ######"

echo "### Installing curl and linux-image packages for docker aufs usage"
apt-get -y install \
  curl \
  linux-image-extra-$(uname -r) \
  linux-image-extra-virtual \
  
echo "### Installing packages to allow repo usage over https"
apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

echo "### Retrive and add docker's official GPG key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo apt-key add -

echo "### Verify key"
apt-key fingerprint 0EBFCD88

echo "### Configure the repo for docker"
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get -y update

echo "### Install docker-engine"
apt-get -y install docker-ce=17.06.2~ce-0~ubuntu

echo "### Test docker installation"
docker run hello-world

echo "###### DOCKER END ######"
