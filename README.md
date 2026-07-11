# 🚀 Engineering for Failure: Building a Highly Available Docker Swarm Cluster on AWS with Terraform


![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?logo=amazonaws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Swarm-2496ED?logo=docker&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04-E95420?logo=ubuntu&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Bash-FCC624?logo=linux&logoColor=black)
![GitHub](https://img.shields.io/badge/GitHub-Version_Control-181717?logo=github&logoColor=white)
![CloudWatch](https://img.shields.io/badge/Amazon_CloudWatch-Monitoring-FF4F8B)

> Production-inspired Docker Swarm project demonstrating high availability, self-healing, leader election, and lightweight EC2 observability.

## 📑 Table of Contents
1. Business Problem
2. Project Objectives
3. Solution Architecture
4. Technology Stack
5. Repository Structure
6. Deployment Guide
7. High Availability Testing
8. CloudWatch Dashboard
9. Validation
10. Interview Talking Points
11. Lessons Learned
12. Future Enhancements

## 💼 Business Problem
Modern production systems must continue serving users when infrastructure components fail. This project demonstrates Docker Swarm self-healing while using a lightweight Amazon CloudWatch dashboard built from native EC2 metrics to visualize infrastructure health.

## 🎯 Project Objectives
- Provision AWS infrastructure with Terraform
- Deploy a 3 Manager / 2 Worker Docker Swarm cluster
- Automatically install Docker with user_data
- Demonstrate container, worker, and manager failures
- Monitor infrastructure with a CloudWatch Dashboard
- Document deployment and recovery procedures

## 🏗️ Solution Architecture

```text
Internet
    │
Docker Routing Mesh
    │
Manager1 (Leader)
 ├── Manager2
 ├── Manager3
 ├── Worker1
 └── Worker2

Docker Service (3 Replicas)

Amazon CloudWatch Dashboard
• CPU Utilization
• Status Checks
• Network In
• Network Out
```

## 🛠️ Technology Stack

| Category | Technology |
|-----------|------------|
| Cloud | AWS EC2, VPC, Security Groups, CloudWatch |
| IaC | Terraform |
| Containers | Docker Swarm |
| OS | Ubuntu 22.04 |
| Automation | Bash |
| Monitoring | Native EC2 Metrics |

## 📂 Repository Structure

```text
terraform/
├── providers.tf
├── variables.tf
├── main.tf
├── outputs.tf
└── docker_install.sh
```

## 🚀 Deployment Guide
1. terraform init
2. terraform validate
3. terraform plan
4. terraform apply
5. Initialize Docker Swarm
6. Join managers
7. Join workers
8. Deploy the service

## 💥 High Availability Testing
- Container failure → Swarm recreates the container.
- Worker failure → Swarm reschedules workloads.
- Manager failure → New leader elected automatically.

## 📊 CloudWatch Dashboard

This project intentionally includes **one lightweight CloudWatch Dashboard** using native EC2 metrics only.

Widgets:
- CPU Utilization
- Status Checks
- Network In
- Network Out

No CloudWatch Agent, Container Insights, SNS, or custom metrics are used to keep the project focused on Docker Swarm rather than observability.

## ✅ Validation

```
docker node ls
docker service ls
docker service ps novatech-web
docker ps
```

Capture screenshots before and after each failure, including the CloudWatch Dashboard.

## 🎤 Interview Talking Points

- Why three managers?
- How does quorum work?
- Difference between container and node failure.
- Why use native CloudWatch metrics instead of Container Insights?
- How would you evolve this into Kubernetes?

## 🎓 Lessons Learned

- Design for failure.
- Automate infrastructure.
- Keep project scope focused.
- Native EC2 metrics provide useful operational visibility with minimal complexity.

## 📈 Future Enhancements

- GitHub Actions
- Amazon EKS
- Prometheus
- Grafana
- Container Insights

## 👤 Author

**Kevin Harding**  
Cloud Engineer | DevOps | AWS
