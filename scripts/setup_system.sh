#!/bin/bash
set -e

echo "=== Setting up system packages ==="
sudo rm -f /etc/apt/sources.list.d/pgdg.list
sudo apt-get update -qq --allow-releaseinfo-change || sudo apt-get update -qq
sudo apt-get install -y openjdk-8-jdk
sudo update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
sudo apt-get install -y wget curl
java -version
