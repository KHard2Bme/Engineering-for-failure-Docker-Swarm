# 🚀 Engineering for Failure: Highly Available Docker Swarm Cluster on AWS with Terraform

![AWS](https://img.shields.io/badge/AWS-EC2%20%7C%20IAM%20%7C%20CloudWatch-FF9900?logo=amazonaws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Swarm-2496ED?logo=docker&logoColor=white)
![Amazon Linux](https://img.shields.io/badge/Amazon%20Linux-2023-FCC624?logo=linux&logoColor=black)
![CloudWatch](https://img.shields.io/badge/Amazon-CloudWatch-FF4F8B)
![Bash](https://img.shields.io/badge/Bash-Scripting-4EAA25?logo=gnubash&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue)

---

# Overview

This project demonstrates how to build a **production-style highly available Docker Swarm cluster on AWS** using **Terraform** while implementing **real-world failure engineering** and **production observability**.

The infrastructure is provisioned entirely with **Terraform**, Docker is automatically installed on every EC2 instance, a custom Apache website is containerized and published to Docker Hub, and Amazon CloudWatch provides centralized monitoring using custom logs, metric filters, alarms, and dashboards.

The project intentionally simulates failures to validate Docker Swarm's self-healing capabilities and operational resilience.

---

# Project Goals

- Provision the entire AWS infrastructure using Terraform
- Automatically install Docker on every EC2 instance
- Configure Amazon Linux 2023
- Build a custom Docker image
- Publish the image to Docker Hub
- Pull and deploy the image across Docker Swarm
- Serve a custom Apache website
- Build and validate a highly available Swarm cluster
- Add production-style CloudWatch monitoring
- Simulate real production failures
- Validate Docker Swarm self-healing

---

# Technology Stack

- AWS EC2
- AWS IAM
- AWS CloudWatch
- Terraform
- Docker
- Docker Swarm
- Docker Hub
- Amazon Linux 2023
- Bash

---

# Repository Structure

```text
terraform/
│
├── main.tf
├── cloudwatch.tf
├── iam.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── docker_install.sh
└── linux2023_updates.sh

docker custom image/
│
├── Dockerfile
└── index.html

cloudwatch scripts/
│
├── cloudwatch_install.sh
├── cloudwatch-agent-config.json
├── cloudwatch_dashboard_update.sh
└── docker_event_monitor.sh

README.md
```

---

# Architecture

```text
                     Terraform
                         │
                         ▼
               AWS Infrastructure
                         │
         ┌───────────────┴───────────────┐
         │                               │
   3 Manager Nodes                 2 Worker Nodes
         │                               │
         └──────── Docker Swarm ─────────┘
                      │
             Custom Apache Website
                      │
               Docker Hub Repository
                      │
             CloudWatch Agent
                      │
             CloudWatch Logs
                      │
             Metric Filters
                      │
         CloudWatch Dashboard
```

---

# Infrastructure Deployment

Terraform provisions:

- VPC
- Public Subnets
- Security Groups
- IAM Roles
- IAM Instance Profiles
- Five EC2 Instances
- CloudWatch Resources

---

# Automated Instance Configuration

Each EC2 instance automatically executes:

## docker_install.sh

- Installs Docker
- Starts Docker
- Enables Docker at boot
- Adds ec2-user to Docker group

## linux2023_updates.sh

- Updates Amazon Linux 2023
- Installs required utilities
- Configures the operating system
- installs Apache 2 Web Server

---

# Building the Docker Image

The project includes a custom Apache website.

Dockerfile

- Apache base image
- Custom index.html
- Port 80 exposed

Commands:

```bash
docker build -t kevd637/apache-website:v1 .
docker push kevd637/apache-website:v1
```

---

# Docker Swarm

Cluster configuration

- Manager1
- Manager2 (Leader)
- Manager3
- Worker1
- Worker2

The website is deployed as a replicated Docker Swarm service.

---

# CloudWatch Monitoring

CloudWatch monitors:

- Container failures
- Worker node failures
- Worker node recovery
- Manager node failures
- Manager node recovery

Monitoring pipeline

```text
Docker Events
      │
docker_event_monitor.sh
      │
/var/log/docker-events.log
      │
CloudWatch Agent
      │
CloudWatch Logs
      │
Metric Filters
      │
CloudWatch Dashboard
```

---

# Supporting Scripts

## docker_install.sh

Automatically installs Docker.

## linux2023_updates.sh

Updates Amazon Linux 2023 and installs Apache 2 web server.

## cloudwatch_install.sh

Installs the CloudWatch Agent.

## cloudwatch-agent-config.json

Configures CloudWatch log collection.

## docker_event_monitor.sh

Monitors Docker events including:

- ContainerFailure
- WorkerNodeFailure
- WorkerNodeRecovered
- ManagerNodeFailure
- ManagerNodeRecovered

## cloudwatch_dashboard_update.sh

Creates and updates CloudWatch dashboards.

---

# Validation Testing

## Phase 1 – Primary Failure Scenarios

### Container Failure

Purpose

Validate container monitoring.

Action

Stop a running container.

Expected Result

- ContainerFailure logged
- CloudWatch metric updated
- Dashboard updated

---

### Worker Node Failure

Purpose

Validate worker failure detection.

Action

```bash
sudo systemctl stop docker
```

Expected Result

- WorkerNodeFailure logged
- Swarm reschedules containers
- Dashboard updated

---

### Manager Node Failure

Purpose

Validate manager failure detection.

Action

```bash
sudo systemctl stop docker
```

Expected Result

- ManagerNodeFailure logged
- Cluster maintains quorum
- Dashboard updated

---

# Phase 2 – Operational Maintenance

## Drain Worker Node

Purpose

Gracefully remove a worker from scheduling.

Expected Result

Tasks migrate automatically.

---

## Drain Manager Node

Purpose

Perform manager maintenance.

Expected Result

Leader election maintained.

---

## Reboot Worker Node

Purpose

Validate node recovery.

Expected Result

Worker rejoins Swarm after reboot.

---

## Restart Docker Service

Purpose

Simulate planned maintenance.

Action

```bash
sudo systemctl stop docker
sudo systemctl start docker
```

Expected Result

- WorkerNodeFailure
- WorkerNodeRecovered

Service availability maintained.

---

# Skills Demonstrated

- Infrastructure as Code
- Terraform
- AWS
- Docker
- Docker Swarm
- Docker Hub
- Linux Administration
- Bash Automation
- Amazon CloudWatch
- Custom Metrics
- Metric Filters
- CloudWatch Dashboards
- Observability
- High Availability
- Incident Response
- Failure Engineering
- Troubleshooting

---

# Lessons Learned

- Infrastructure as Code provides repeatable deployments.
- Docker Swarm automatically redistributes workloads.
- CloudWatch custom metrics provide excellent operational visibility.
- Monitoring both infrastructure and applications is essential.
- Failure testing validates production readiness.
- Planned maintenance is just as important as unexpected failures.

---

# Future Enhancements

- Deploy behind an AWS Application Load Balancer
- Configure docker_event_monitor.sh as a systemd service
- Add CloudWatch alarms with Amazon SNS notifications
- Integrate Prometheus
- Integrate Grafana
- Implement GitHub Actions CI/CD
- Add rolling deployments
- Add blue/green deployments

---

# Author

**Kevin Harding**

Marine Corps Veteran

AWS Certified Solutions Architect – Associate

Cloud / DevOps Engineer

---

## If you found this project useful, please consider giving it a ⭐ on GitHub!
