#!/bin/bash
set -e

sudo tee /etc/hadoop/conf/core-site.xml > /dev/null <<EOF
<?xml version="1.0"?>
<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://localhost:9000</value>
  </property>
  <property>
    <name>hadoop.tmp.dir</name>
    <value>/tmp/hadoop-\${user.name}</value>
  </property>
</configuration>
EOF

sudo tee /etc/hadoop/conf/hdfs-site.xml > /dev/null <<EOF
<?xml version="1.0"?>
<configuration>
  <property>
    <name>dfs.replication</name>
    <value>1</value>
  </property>
  <property>
    <name>dfs.namenode.name.dir</name>
    <value>/tmp/hadoop-namenode</value>
  </property>
  <property>
    <name>dfs.datanode.data.dir</name>
    <value>/tmp/hadoop-datanode</value>
  </property>
</configuration>
EOF

sudo tee /etc/hadoop/conf/mapred-site.xml > /dev/null <<EOF
<?xml version="1.0"?>
<configuration>
  <property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
  </property>
</configuration>
EOF

sudo tee /etc/hadoop/conf/yarn-site.xml > /dev/null <<EOF
<?xml version="1.0"?>
<configuration>
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
  <property>
    <name>yarn.resourcemanager.hostname</name>
    <value>localhost</value>
  </property>
</configuration>
EOF

export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

mkdir -p /tmp/hadoop-namenode
mkdir -p /tmp/hadoop-datanode

