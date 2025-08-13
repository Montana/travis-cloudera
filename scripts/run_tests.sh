#!/bin/bash
set -e

java -version
cloudera-scm-agent --version || echo "CM Agent not fully configured (expected in CI)"
ls -la /opt/cloudera/
ls -la /etc/hadoop/conf/

python3 -c "
import xml.etree.ElementTree as ET
configs = ['core-site.xml', 'hdfs-site.xml', 'mapred-site.xml', 'yarn-site.xml']
for config in configs:
    try:
        tree = ET.parse(f'/etc/hadoop/conf/{config}')
        print(f'{config} is valid XML')
    except Exception as e:
        print(f'Error parsing {config}: {e}')
        exit(1)
"

docker --version

curl -s --head https://archive.cloudera.com/ | head -n 1

test -r /etc/hadoop/conf/core-site.xml && echo "Configuration files are readable"
test -w /opt/cloudera/ && echo "Cloudera directory is writable"

if command -v hdfs &> /dev/null; then
    echo "Testing HDFS commands..."
    hdfs version || echo "HDFS command available but not configured"
fi
