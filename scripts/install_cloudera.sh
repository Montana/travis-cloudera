#!/bin/bash
set -e

wget -q https://archive.cloudera.com/cm7/${CLOUDERA_MANAGER_VERSION}/ubuntu2004/apt/cloudera-manager.list
sudo cp cloudera-manager.list /etc/apt/sources.list.d/
wget -q https://archive.cloudera.com/cm7/${CLOUDERA_MANAGER_VERSION}/ubuntu2004/apt/archive.key
sudo apt-key add archive.key
sudo apt-get update
sudo apt-get install -y cloudera-manager-agent
sudo mkdir -p /opt/cloudera/parcels
sudo mkdir -p /etc/hadoop/conf
sudo mkdir -p /var/log/cloudera-scm-agent
sudo chown -R $USER:$USER /opt/cloudera
sudo chown -R $USER:$USER /var/log/cloudera-scm-agent
rm -f cloudera-manager.list archive.key
