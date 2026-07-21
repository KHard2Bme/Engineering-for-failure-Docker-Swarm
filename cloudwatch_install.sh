#!/bin/bash
#
# cloudwatch_install.sh
#
# Installs and configures the Amazon CloudWatch Agent on
# Amazon Linux 2023 EC2 instances.
#

set -euo pipefail

CONFIG_FILE="./cloudwatch-agent-config.json"
DEST_CONFIG="/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json"

echo "=== Engineering for Failure - CloudWatch Agent Installation ==="

if [[ $EUID -ne 0 ]]; then
  echo "Please run this script with sudo."
  exit 1
fi

echo "[1/7] Updating system packages..."
dnf update -y

echo "[2/7] Installing CloudWatch Agent..."
dnf install -y amazon-cloudwatch-agent

echo "[3/7] Verifying AWS CLI..."
if ! command -v aws >/dev/null 2>&1; then
  echo "Installing AWS CLI..."
  dnf install -y awscli
fi

echo "[4/7] Verifying jq..."
if ! command -v jq >/dev/null 2>&1; then
  echo "Installing jq..."
  dnf install -y jq
fi

echo "[5/7] Copying CloudWatch Agent configuration..."
if [[ ! -f "${CONFIG_FILE}" ]]; then
  echo "ERROR: ${CONFIG_FILE} not found."
  exit 1
fi

mkdir -p /opt/aws/amazon-cloudwatch-agent/etc
cp "${CONFIG_FILE}" "${DEST_CONFIG}"

echo "[6/7] Starting CloudWatch Agent..."
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl   -a stop || true

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl   -a fetch-config   -m ec2   -c file:${DEST_CONFIG}   -s

echo "[7/7] Verifying service..."
systemctl enable amazon-cloudwatch-agent
systemctl restart amazon-cloudwatch-agent
systemctl --no-pager --full status amazon-cloudwatch-agent || true

echo
echo "========================================="
echo "CloudWatch Agent installation complete."
echo "========================================="
echo
echo "Next steps:"
echo "1. Verify logs appear in CloudWatch Logs."
echo "2. Run your Engineering for Failure tests."
echo "3. Execute cloudwatch_dashboard_update.sh"
