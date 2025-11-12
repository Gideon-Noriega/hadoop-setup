#!/bin/bash

# Hadoop Startup Script
# Starts HDFS and YARN services

echo "=========================================="
echo "Starting Hadoop Services"
echo "=========================================="

# Set environment variables
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

echo "Step 1: Starting HDFS services..."
start-dfs.sh

echo ""
echo "Step 2: Starting YARN services..."
start-yarn.sh

echo ""
echo "Step 3: Waiting for services to start..."
sleep 5

echo ""
echo "Step 4: Verifying running services..."
jps

echo ""
echo "=========================================="
echo "Hadoop services started successfully!"
echo "=========================================="
echo "HDFS Web UI: http://localhost:9870"
echo "YARN Web UI: http://localhost:8088"
echo "=========================================="