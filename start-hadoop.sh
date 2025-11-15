#!/bin/bash

# Hadoop Startup Script
# Starts HDFS and YARN services

# Set environment variables
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Check if running as service or interactive
if [ -t 1 ]; then
    # Interactive mode - show output
    echo "=========================================="
    echo "Starting Hadoop Services"
    echo "=========================================="
    
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
else
    # Service mode - log to file
    LOG_FILE="/var/log/hadoop-startup.log"
    
    # Function to log messages
    log_message() {
        echo "$(date): $1" | sudo tee -a $LOG_FILE
    }
    
    log_message "Starting Hadoop Services"
    
    # Start HDFS services
    log_message "Starting HDFS services..."
    start-dfs.sh >> $LOG_FILE 2>&1
    
    # Start YARN services
    log_message "Starting YARN services..."
    start-yarn.sh >> $LOG_FILE 2>&1
    
    # Wait for services to start
    sleep 10
    
    # Verify services
    log_message "Verifying running services..."
    jps >> $LOG_FILE 2>&1
    
    log_message "Hadoop services startup completed"
fi