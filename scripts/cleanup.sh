#!/bin/bash

STATUS=$1

sudo service cloudera-scm-agent stop || echo "Agent not running"

docker ps -q | xargs -r docker kill || echo "No running containers"
docker ps -aq | xargs -r docker rm || echo "No containers to remove"

rm -rf /tmp/hadoop-*

if [ "$STATUS" = "failure" ]; then
    echo "=== Failure Diagnostics ==="
    
    if [ -f /var/log/cloudera-scm-agent/cloudera-scm-agent.log ]; then
        echo "Last 20 lines of Cloudera Agent log:"
        tail -20 /var/log/cloudera-scm-agent/cloudera-scm-agent.log
    else
        echo "No Cloudera Agent log found"
    fi
    
    df -h # show remaining space lol
    free -h
    
    ps aux | grep -E "(java|hadoop|cloudera)" || echo "No relevant processes found"
    
elif [ "$STATUS" = "success" ]; then
    echo "=== Success Summary ==="
    echo "Cloudera CI pipeline completed successfully"
    
    echo "Final system status:"
    df -h /opt/cloudera || echo "Cloudera directory not mounted"
    ls -la /etc/hadoop/conf/ || echo "Hadoop config directory not found"
fi

sudo rm -f /etc/apt/sources.list.d/cloudera-manager.list || echo "Repository file already removed"
