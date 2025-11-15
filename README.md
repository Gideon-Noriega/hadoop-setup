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

### Auto-Start Service (Optional)
```bash
# Install as system service for auto-start on boot
./install-service.sh

# Manage service
sudo systemctl start hadoop
sudo systemctl stop hadoop
sudo systemctl status hadoop
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
- `install-service.sh` - Install Hadoop as auto-start service
- `hadoop.service` - systemd service configuration

## Tested Environment

- Ubuntu 22.04 LTS
- Java 11 (OpenJDK)
- Hadoop 3.4.2
- Spark 4.0.1 (integration verified)

## Manual Installation

For step-by-step manual installation, see [HADOOP_SETUP_GUIDE.md](HADOOP_SETUP_GUIDE.md) which includes:

### Prerequisites
- Ubuntu/Debian Linux system
- Terminal access with sudo privileges

### Installation Steps
1. **System Update** - Update packages
2. **Java Installation** - Install OpenJDK 11
3. **Download Hadoop** - Get Hadoop 3.4.2 binary
4. **Extract and Install** - Set up Hadoop directory
5. **Environment Configuration** - Configure environment variables
6. **Hadoop Configuration** - Set up all config files:
   - `hadoop-env.sh` - Java home configuration
   - `core-site.xml` - Default filesystem
   - `hdfs-site.xml` - HDFS settings
   - `mapred-site.xml` - MapReduce framework
   - `yarn-site.xml` - YARN configuration
7. **Format HDFS** - Initialize the namenode
8. **SSH Setup** - Configure passwordless authentication
9. **Start Services** - Launch HDFS and YARN
10. **Verification** - Test installation

### Configuration Files
The manual guide includes all necessary XML configurations for:
- Core Hadoop settings
- HDFS replication and storage
- YARN resource management
- MapReduce job execution

## Notes

- Native library warnings are normal and don't affect functionality
- SSH passwordless authentication is configured automatically
- All services start on localhost for single-node setup

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is open source and available under the MIT License.