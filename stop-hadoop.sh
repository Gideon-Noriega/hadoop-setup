#!/bin/bash

# Hadoop Stop Script
# Stops YARN and HDFS services

echo "=========================================="
echo "Stopping Hadoop Services"
echo "=========================================="

# Set environment variables
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

echo "Step 1: Stopping YARN services..."
stop-yarn.sh

echo ""
echo "Step 2: Stopping HDFS services..."
stop-dfs.sh

echo ""
echo "Step 3: Verifying services stopped..."
jps

echo ""
echo "=========================================="
echo "Hadoop services stopped successfully!"
echo "=========================================="