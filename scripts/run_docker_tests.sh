#!/bin/bash
set -e

docker --version

if docker pull cloudera/quickstart:latest; then
    echo "Successfully pulled Cloudera quickstart image"
    
    docker run --rm cloudera/quickstart:latest echo "Cloudera container test successful"
    docker run --rm -v $(pwd):/workspace cloudera/quickstart:latest ls -la /workspace
    
else
    echo "Docker image not available, testing alternative images..."
    
    if docker pull sequenceiq/hadoop-docker:latest; then
        echo "Using alternative Hadoop Docker image"
        docker run --rm sequenceiq/hadoop-docker:latest echo "Alternative Hadoop container test successful"
    else
        echo "No suitable Docker images available"
    fi
fi

docker network ls

if command -v docker-compose &> /dev/null; then
    echo "Docker Compose is available"
    docker-compose --version
fi
