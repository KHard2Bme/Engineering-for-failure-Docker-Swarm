#!/bin/bash

#########################################################
# Ubuntu System Update Script
# Author: Kevin Harding
# Description:
# Updates Ubuntu packages and installs Apache2
#########################################################

echo "======================================"
echo "Updating package repository..."
echo "======================================"

sudo apt-get update

echo "======================================"
echo "Upgrading installed packages..."
echo "======================================"

sudo apt-get upgrade -y

echo "======================================"
echo "Installing Apache2..."
echo "======================================"

sudo apt-get install -y apache2

echo "======================================"
echo "Enabling Apache2..."
echo "======================================"

sudo systemctl enable apache2

echo "======================================"
echo "Starting Apache2..."
echo "======================================"

sudo systemctl start apache2

echo "======================================"
echo "Apache2 Status"
echo "======================================"

sudo systemctl status apache2 --no-pager

echo "======================================"
echo "Apache Version"
echo "======================================"

apache2 -v

echo "======================================"
echo "Script Complete!"
echo "======================================"