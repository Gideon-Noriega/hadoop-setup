# Hadoop Auto-Start Service

This guide explains how to set up Hadoop to start automatically when the system boots.

## Installation

Run the service installation script:
```bash
./install-service.sh
```

## Service Management

After installation, use these commands to manage the Hadoop service:

```bash
# Start Hadoop services
sudo systemctl start hadoop

# Stop Hadoop services
sudo systemctl stop hadoop

# Check service status
sudo systemctl status hadoop

# Restart Hadoop services
sudo systemctl restart hadoop

# View service logs
sudo journalctl -u hadoop -f
```

## Auto-Start Configuration

The service is automatically enabled to start on boot. To disable/enable:

```bash
# Disable auto-start
sudo systemctl disable hadoop

# Enable auto-start
sudo systemctl enable hadoop
```

## Log Files

Service logs are written to:
- System logs: `sudo journalctl -u hadoop`
- Hadoop startup logs: `/var/log/hadoop-startup.log`

## Script Behavior

The `start-hadoop.sh` script automatically detects how it's being run:

**Interactive Mode** (manual execution):
- Shows progress messages and colorful output
- Displays web UI links after startup
- Shorter wait times for immediate feedback

**Service Mode** (systemd execution):
- Logs all output to `/var/log/hadoop-startup.log`
- No interactive output to console
- Longer wait times for reliable service startup

## Files

- `hadoop.service` - systemd service configuration
- `start-hadoop.sh` - Startup script (works both interactively and as service)
- `install-service.sh` - Service installation script

## Notes

- The service runs as the `gkipsang` user
- All environment variables are configured in the service file
- The service waits for network and SSH to be available before starting
- Script automatically adapts behavior based on execution context