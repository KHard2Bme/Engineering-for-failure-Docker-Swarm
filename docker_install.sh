#!/bin/bash
set -euxo pipefail

dnf update -y
dnf install -y docker

systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user

docker --version > /var/log/docker-version.log

