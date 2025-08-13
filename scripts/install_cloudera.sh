#!/bin/bash
set -e

cat > cloudera-manager.list << EOF
deb [arch=amd64] https://archive.cloudera.com/cm7/${CLOUDERA_MANAGER_VERSION}/ubuntu2004/apt focal-cm7.4.4 contrib
deb-src https://archive.cloudera.com/cm7/${CLOUDERA_MANAGER_VERSION}/ubuntu2004/apt focal-cm7.4.4 contrib
EOF

sudo cp cloudera-manager.list /etc/apt/sources.list.d/

wget -q https://archive.cloudera.com/cm7/${CLOUDERA_MANAGER_VERSION}/ubuntu2004/apt/archive.key
sudo apt-key add archive.key

sudo apt-get update --allow-unauthenticated

sudo apt-get install -y --allow-unauthenticated cloudera-manager-agent

sudo mkdir -p /opt/cloudera/parcels
sudo mkdir -p /etc/hadoop/conf
sudo mkdir -p /var/log/cloudera-scm-agent

sudo chown -R $USER:$USER /opt/cloudera
sudo chown -R $USER:$USER /var/log/cloudera-scm-agent

rm -f cloudera-manager.list archive.key
