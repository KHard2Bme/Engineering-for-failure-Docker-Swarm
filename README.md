# Engineering for Failure: Docker Swarm on AWS with Terraform

![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?logo=amazonaws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Swarm-2496ED?logo=docker&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04-E95420?logo=ubuntu&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Bash-FCC624?logo=linux&logoColor=black)
![GitHub](https://img.shields.io/badge/GitHub-Version_Control-181717?logo=github&logoColor=white)
![CloudWatch](https://img.shields.io/badge/Amazon_CloudWatch-Monitoring-FF4F8B)

## Overview

This project provisions a five-node Docker Swarm cluster on AWS using
Terraform to demonstrate Infrastructure as Code (IaC), AWS networking,
Linux administration, Docker orchestration, and CloudWatch monitoring.
The environment is intentionally simple, reproducible, and designed as a
portfolio project that showcases core DevOps engineering skills.

------------------------------------------------------------------------
# Repository Structure
```
terraform/
   ├── providers.tf
   ├── variables.tf
   ├── main.tf
   ├── outputs.tf
   │
   └── docker_install.sh
   └── ubuntu_updates.sh
   └── README.md
```
---------------------------------------------------------------------
# Architecture

```
Internet
    │
Application Load (via Docker Routing Mesh)
    │
┌───────────────────────────────────┐
│        VPC (10.0.0.0/16)          │
│                                   │
│  Public Subnet A (us-east-1a)     │
│  • Manager1                       │
│  • Manager2                       │
│  • Worker1                        │
│                                   │
│  Public Subnet B (us-east-1b)     │
│  • Manager3                       │
│  • Worker2                        │
└───────────────────────────────────┘
              │
      Docker Swarm Cluster
              │
      Amazon CloudWatch Dashboard
      • CPU Utilization
      • Status Checks
      • Network In
      • Network Out
```

## AWS Region

-   us-east-1

## Networking

-   VPC: 10.0.0.0/16
-   Public Subnet A: 10.0.1.0/24 (us-east-1a)
-   Public Subnet B: 10.0.2.0/24 (us-east-1b)
-   Internet Gateway
-   Public Route Table

## EC2 Infrastructure

```
Instance   Availability Zone      Role
  ---------- ------------------- ---------------
   Manager1   us-east-1a          Swarm Manager
   Manager2   us-east-1a          Swarm Manager
   Manager3   us-east-1b          Swarm Manager
   Worker1    us-east-1a          Swarm Worker
   Worker2    us-east-1b          Swarm Worker

```
Each EC2 instance: 
- Amazon Linux 2023
- t2.micro
- Public IP Address
- Docker installed automatically through `docker_install.sh`

--------------------------------------------------------------------

# Supporting Scripts

## docker_install.sh

Executed automatically by Terraform using `user_data`, this script
prepares each EC2 instance by: - Updating the operating system. -
Installing Docker. - Enabling and starting the Docker service. - Adding
the `ec2-user` account to the Docker group. - Installing the Docker
Compose plugin. - Verifying the Docker installation.

## ubuntu_updates.sh

The `ubuntu_updates.sh` script is included as a standalone Linux
administration example and is **not** executed as part of the Terraform
deployment because the infrastructure uses Amazon Linux 2023 rather than
Ubuntu. The script demonstrates common system administration tasks,
including updating package repositories, upgrading installed packages,
installing Apache2, enabling the Apache service, starting the service,
and verifying the installation. It showcases Bash scripting and Linux
automation skills that are transferable across distributions.

------------------------------------------------------------------------
# Security

The security group allows:

-   TCP 22 (SSH)
-   TCP 80 (HTTP)
-   TCP 2377 (Docker Swarm Management)
-   TCP/UDP 7946 (Cluster Communication)
-   UDP 4789 (Overlay Networking)

------------------------------------------------------------------------

# Monitoring

A custom Amazon CloudWatch Dashboard provides visibility into:

-   CPU Utilization
-   Status Checks
-   Network In
-   Network Out

This version intentionally does **not** include:

-   CloudWatch Agent
-   CloudWatch Metric Filters
-   CloudWatch Alarms
-   Amazon SNS

------------------------------------------------------------------------



------------------------------------------------------------------------

# Deployment

Initialize Terraform:

``` bash
terraform init
```

Review the execution plan:

``` bash
terraform plan
```

Deploy the infrastructure:

``` bash
terraform apply
```

Remove the infrastructure:

``` bash
terraform destroy
```

------------------------------------------------------------------------

# Configure Docker Swarm

On **Manager1**:

``` bash
docker swarm init
```

Display the manager join token:

``` bash
docker swarm join-token manager
```

Display the worker join token:

``` bash
docker swarm join-token worker
```

Verify the cluster:

``` bash
docker node ls
```

------------------------------------------------------------------------

# Skills Demonstrated

-   Terraform
-   Infrastructure as Code
-   AWS VPC Design
-   EC2 Provisioning
-   Docker Swarm Administration
-   Linux Administration
-   Cloud Networking
-   Amazon CloudWatch Dashboards

------------------------------------------------------------------------

# Engineering for Failure

This project provides a platform for testing how Docker Swarm responds
to infrastructure failures. You can stop manager or worker nodes,
observe quorum behavior, verify workload resiliency, and monitor the
cluster through CloudWatch metrics. These exercises reinforce high
availability concepts and operational troubleshooting.

------------------------------------------------------------------------

# Future Enhancements

-   Application Load Balancer
-   Auto Scaling
-   Private Subnets
-   NAT Gateway
-   AWS Systems Manager Session Manager
-   IAM Least-Privilege Policies
-   GitHub Actions CI/CD
-   Prometheus
-   Grafana

------------------------------------------------------------------------

# Author

**Kevin Harding**

-   GitHub: https://github.com/KHard2bme
-   LinkedIn: https://www.linkedin.com/in/kevin-harding-ab0a0816
