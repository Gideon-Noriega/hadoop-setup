#!/bin/bash

# Hadoop 3.4.2 Automated Installation Script
# Author: Generated from manual installation documentation
# Date: $(date)

set -e  # Exit on any error

echo "=========================================="
echo "Hadoop 3.4.2 Automated Installation"
echo "=========================================="

# Step 1: System Update
echo "Step 1: Updating system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Step 2: Java Installation
echo "Step 2: Installing OpenJDK 11..."
sudo apt-get install openjdk-11-jdk -y

# Verify Java installation
java --version

# Step 3: Download Hadoop
echo "Step 3: Downloading Hadoop 3.4.2..."
cd ~/spark_tutorial/hadoop-setup
wget -O hadoop-3.4.2.tar.gz https://downloads.apache.org/hadoop/common/hadoop-3.4.2/hadoop-3.4.2.tar.gz

# Step 4: Extract and Install Hadoop
echo "Step 4: Extracting and installing Hadoop..."
tar -xzf hadoop-3.4.2.tar.gz
sudo mkdir -p /usr/local/hadoop
sudo mv hadoop-3.4.2/* /usr/local/hadoop/
sudo chown -R $USER:$USER /usr/local/hadoop

# Step 5: Environment Configuration
echo "Step 5: Configuring environment variables..."
cat >> ~/.bashrc << 'EOF'

# Set Hadoop-related environment variables
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

# Set Java Home
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
EOF

source ~/.bashrc

# Step 6: Setup SSH for Hadoop
echo "Step 6: Setting up SSH for passwordless login..."
sudo apt-get install openssh-server -y
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

# Test SSH connection (accept host key)
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
ssh-keyscan -H 0.0.0.0 >> ~/.ssh/known_hosts
ssh-keyscan -H $(hostname) >> ~/.ssh/known_hosts

# Step 7: Configure Hadoop Environment
echo "Step 7: Configuring Hadoop environment..."
echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> /usr/local/hadoop/etc/hadoop/hadoop-env.sh

# Step 8: Configure Core Site
echo "Step 8: Configuring core-site.xml..."
sed -i '/<configuration>/a\    <property>\n        <name>fs.defaultFS</name>\n        <value>hdfs://localhost:9000</value>\n    </property>' /usr/local/hadoop/etc/hadoop/core-site.xml

# Step 9: Configure HDFS Site
echo "Step 9: Configuring hdfs-site.xml..."
sed -i '/<configuration>/a\    <property>\n        <name>dfs.replication</name>\n        <value>1</value>\n    </property>\n    <property>\n        <name>dfs.namenode.name.dir</name>\n        <value>file:///usr/local/hadoop/hadoop_data/hdfs/namenode</value>\n    </property>\n    <property>\n        <name>dfs.datanode.data.dir</name>\n        <value>file:///usr/local/hadoop/hadoop_data/hdfs/datanode</value>\n    </property>' /usr/local/hadoop/etc/hadoop/hdfs-site.xml

# Step 10: Configure MapReduce Site
echo "Step 10: Configuring mapred-site.xml..."
sed -i '/<configuration>/a\    <property>\n        <name>mapreduce.framework.name</name>\n        <value>yarn</value>\n    </property>' /usr/local/hadoop/etc/hadoop/mapred-site.xml

# Step 11: Configure YARN Site
echo "Step 11: Configuring yarn-site.xml..."
sed -i '/<configuration>/a\    <property>\n        <name>yarn.nodemanager.aux-services</name>\n        <value>mapreduce_shuffle</value>\n    </property>\n    <property>\n        <name>yarn.nodemanager.env-whitelist</name>\n        <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_CONF_DIR,HADOOP_HDFS_HOME,HADOOP_HOME,HADOOP_MAPRED_HOME,HADOOP_YARN_HOME</value>\n    </property>' /usr/local/hadoop/etc/hadoop/yarn-site.xml

# Set environment variables for current session
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Step 12: Format HDFS Namenode
echo "Step 12: Formatting HDFS namenode..."
echo "Y" | hdfs namenode -format

# Step 13: Start HDFS Services
echo "Step 13: Starting HDFS services..."
start-dfs.sh

# Step 14: Verify HDFS Services
echo "Step 14: Verifying HDFS services..."
sleep 5
jps

# Step 15: Verify Installation
echo "Step 15: Verifying Hadoop installation..."
hadoop version

echo "=========================================="
echo "Hadoop installation completed successfully!"
echo "=========================================="
echo "HDFS Web UI: http://localhost:9870"
echo "To start YARN services, run: start-yarn.sh"
echo "To check running services, run: jps"
echo "=========================================="