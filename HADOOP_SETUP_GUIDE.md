# Hadoop Setup Guide

## Prerequisites
- Ubuntu/Debian-based Linux system
- Terminal access with sudo privileges

## Step 1: System Update
```bash
sudo apt-get update
sudo apt-get upgrade
```

## Step 2: Java Installation
Check if Java is already installed:
```bash
which openjdk
java --version
```

Install OpenJDK 11:
```bash
sudo apt-get install openjdk-11-jdk -y
```

Verify installation:
```bash
java --version
```

## Step 3: Download Hadoop
Download Hadoop 3.4.2 binary:
```bash
wget https://downloads.apache.org/hadoop/common/hadoop-3.4.2/hadoop-3.4.2.tar.gz
```

## Step 4: Extract and Install Hadoop
Extract the downloaded file:
```bash
tar -xzvf hadoop-3.4.2.tar.gz
```

Move the contents to system directory:
```bash
sudo mv hadoop-3.4.2/* /usr/local/hadoop/
```
Note: Create the hadoop directory first if it doesn't exist:
```bash
sudo mkdir -p /usr/local/hadoop
```

## Step 5: Environment Configuration
Edit the bashrc file:
```bash
vim ~/.bashrc
```

Add the following environment variables to the end of `~/.bashrc`:
```bash
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
```

Apply the changes:
```bash
source ~/.bashrc
```

## Step 6: Configure Hadoop Environment
Edit Hadoop environment configuration:
```bash
vim $HADOOP_HOME/etc/hadoop/hadoop-env.sh
```

Add the following line:
```bash
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
```

## Step 7: Configure Core Site
Edit core-site.xml:
```bash
vim $HADOOP_HOME/etc/hadoop/core-site.xml
```

Add the following configuration:
```xml
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>
```

## Step 8: Configure HDFS Site
Edit hdfs-site.xml:
```bash
vim $HADOOP_HOME/etc/hadoop/hdfs-site.xml
```

Add the following configuration:
```xml
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:///usr/local/hadoop/hadoop_data/hdfs/namenode</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>file:///usr/local/hadoop/hadoop_data/hdfs/datanode</value>
    </property>
</configuration>
```

## Step 9: Configure MapReduce Site
Edit mapred-site.xml:
```bash
vim $HADOOP_HOME/etc/hadoop/mapred-site.xml
```

Add the following configuration:
```xml
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
```

## Step 10: Configure YARN Site
Edit yarn-site.xml:
```bash
vim $HADOOP_HOME/etc/hadoop/yarn-site.xml
```

Add the following configuration:
```xml
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.env-whitelist</name>
        <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_CONF_DIR,HADOOP_HDFS_HOME,HADOOP_HOME,HADOOP_MAPRED_HOME,HADOOP_YARN_HOME</value>
    </property>
</configuration>
```

## Step 11: Format HDFS Namenode
Format the HDFS namenode to initialize the file system:
```bash
hdfs namenode -format
```

Expected output should show:
- Storage directory successfully formatted
- Cluster ID assigned
- FSImage saved successfully

## Step 12: Start HDFS Services
Start the Hadoop Distributed File System:
```bash
start-dfs.sh
```

Expected output:
- Starting namenodes on [localhost]
- Starting datanodes
- Starting secondary namenodes

## Step 13: Verify HDFS Services
Check running Java processes:
```bash
jps
```

Expected output should show:
- NameNode
- DataNode  
- SecondaryNameNode

## Step 14: Start YARN Services
Start YARN resource manager and node managers:
```bash
start-yarn.sh
```

Expected output:
- Starting resourcemanager
- Starting nodemanagers

## Step 15: Verify All Services
Check all running Java processes:
```bash
jps
```

Expected output should show:
- NameNode
- DataNode
- SecondaryNameNode
- ResourceManager
- NodeManager

## Step 16: Test HDFS Operations
Test basic HDFS operations:
```bash
# Create a directory in HDFS
hdfs dfs -mkdir /test

# List root directory contents
hdfs dfs -ls /

# List user home directory (initially empty)
hdfs dfs -ls
```

## Step 17: Verify Installation
Check Hadoop version:
```bash
hadoop version
```

## Current Status
✅ System updated
✅ Java 11 installed
✅ Hadoop downloaded and extracted
✅ Hadoop contents moved to /usr/local/hadoop
✅ Environment variables configured
✅ Hadoop environment configured
✅ Core site configured
✅ HDFS site configured
✅ MapReduce site configured
✅ YARN site configured
✅ HDFS namenode formatted
✅ SSH passwordless login configured
✅ HDFS services started successfully
✅ YARN services started successfully
✅ All services verified and running
✅ HDFS operations tested successfully
✅ Installation completed and verified (Hadoop 3.4.2)

## Step 18: Setup SSH for Passwordless Login
Install SSH server and generate keys:
```bash
sudo apt-get install openssh-server -y
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
```

Add host keys:
```bash
ssh-keyscan -H localhost >> ~/.ssh/known_hosts
ssh-keyscan -H 0.0.0.0 >> ~/.ssh/known_hosts
ssh-keyscan -H $(hostname) >> ~/.ssh/known_hosts
```

## Hadoop Installation Complete! 🎉

### Web Interfaces
- **HDFS NameNode UI**: http://localhost:9870
- **YARN ResourceManager UI**: http://localhost:8088

### Running Services
All Hadoop services are running:
- NameNode (HDFS metadata management)
- DataNode (HDFS data storage)
- SecondaryNameNode (HDFS checkpointing)
- ResourceManager (YARN resource management)
- NodeManager (YARN node management)

### Spark Integration Verified! ✅
Successfully ran Spark job on Hadoop cluster:
```bash
spark-submit --master spark://datastream:7077 \
    --class org.apache.spark.examples.SparkPi \
    $SPARK_HOME/examples/jars/spark-examples_2.13-4.0.1.jar 10
```
**Result**: Pi is roughly 3.1423471423471425

### Complete Big Data Stack
- ✅ **Hadoop 3.4.2** - Distributed storage and resource management
- ✅ **Spark 4.0.1** - Fast distributed computing engine
- ✅ **HDFS** - Distributed file system
- ✅ **YARN** - Resource management and job scheduling

### Next Steps
- [ ] Run custom Spark applications
- [ ] Process large datasets
- [ ] Explore Spark SQL and DataFrames
- [ ] Set up data pipelines

## Notes
- Hadoop installation directory: `/usr/local/hadoop`
- Java installation directory: `/usr/lib/jvm/java-11-openjdk-amd64`
- Configuration files location: `$HADOOP_HOME/etc/hadoop/`