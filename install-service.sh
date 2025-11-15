#!/bin/bash

# Install Hadoop as a systemd service

echo "Installing Hadoop as a system service..."

# Copy service file to systemd directory
sudo cp hadoop.service /etc/systemd/system/

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable the service to start on boot
sudo systemctl enable hadoop.service

echo "Hadoop service installed successfully!"
echo ""
echo "Service commands:"
echo "  Start:   sudo systemctl start hadoop"
echo "  Stop:    sudo systemctl stop hadoop"
echo "  Status:  sudo systemctl status hadoop"
echo "  Restart: sudo systemctl restart hadoop"
echo ""
echo "The service will now start automatically on system boot."