#!/bin/bash
set -e

sudo rm -f /etc/apt/sources.list.d/pgdg.list
sudo rm -f /etc/apt/sources.list.d/postgresql.list
sudo rm -f /etc/apt/sources.list.d/*postgresql* # can use deprecated root source, but for the sake of time and legacy. 
sudo rm -f /etc/apt/sources.list.d/*cloudera*

sudo sed -i '/postgresql/d' /etc/apt/sources.list
sudo sed -i '/cloudera/d' /etc/apt/sources.list

sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

sudo apt-get update -qq

sudo apt-get install -y openjdk-8-jdk

sudo update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

sudo apt-get install -y wget curl

java -version
