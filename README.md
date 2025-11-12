# Hadoop 3.4.2 Setup Guide

Complete installation and configuration guide for Apache Hadoop 3.4.2 on Ubuntu/Debian systems.

## Quick Start

### Automated Installation
```bash
chmod +x install_hadoop.sh
./install_hadoop.sh
```

### Manual Start/Stop
```bash
# Start Hadoop services
./start-hadoop.sh

# Stop Hadoop services
./stop-hadoop.sh
```

## What's Included

- **Complete Installation Guide** - Step-by-step manual setup
- **Automated Installation Script** - One-click setup
- **Startup/Shutdown Scripts** - Easy service management
- **Configuration Files** - All necessary Hadoop configs

## Components Installed

- **Hadoop 3.4.2** - Distributed storage and processing
- **HDFS** - Hadoop Distributed File System
- **YARN** - Resource management and job scheduling
- **MapReduce** - Distributed computing framework

## Services Running

After installation, these services will be running:
- NameNode (HDFS metadata)
- DataNode (HDFS storage)
- SecondaryNameNode (HDFS checkpointing)
- ResourceManager (YARN resource management)
- NodeManager (YARN node management)

## Web Interfaces

- **HDFS NameNode UI**: http://localhost:9870
- **YARN ResourceManager UI**: http://localhost:8088

## Verification

Test HDFS operations:
```bash
hdfs dfs -mkdir /test
hdfs dfs -ls /
```

Check running services:
```bash
jps
```

## Requirements

- Ubuntu/Debian Linux
- Java 11 (OpenJDK)
- SSH server
- sudo privileges

## Files

- `HADOOP_SETUP_GUIDE.md` - Complete manual installation guide
- `install_hadoop.sh` - Automated installation script
- `start-hadoop.sh` - Start all Hadoop services
- `stop-hadoop.sh` - Stop all Hadoop services

## Tested Environment

- Ubuntu 22.04 LTS
- Java 11 (OpenJDK)
- Hadoop 3.4.2
- Spark 4.0.1 (integration verified)

## Notes

- Native library warnings are normal and don't affect functionality
- SSH passwordless authentication is configured automatically
- All services start on localhost for single-node setup

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is open source and available under the MIT License.