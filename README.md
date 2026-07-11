# 🚀 Engineering for Failure: Building a Highly Available Docker Swarm Cluster on AWS with Terraform

![AWS](https://img.shields.io/badge/AWS-EC2-FF9900?logo=amazonaws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Swarm-2496ED?logo=docker&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04-E95420?logo=ubuntu&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-Bash-FCC624?logo=linux&logoColor=black)
![GitHub](https://img.shields.io/badge/GitHub-Version_Control-181717?logo=github&logoColor=white)

> **A production-style high availability project demonstrating Docker
> Swarm, Terraform, AWS, and fault tolerance through real-world failure
> scenarios.**

------------------------------------------------------------------------

# 📑 Table of Contents

1.  Business Problem
2.  Project Objectives
3.  Solution Architecture
4.  Technology Stack
5.  Repository Structure
6.  Deployment Guide
7.  Failure Scenarios
8.  Validation Commands
9.  Interview Talking Points
10. Lessons Learned
11. Future Enhancements

------------------------------------------------------------------------

# 💼 Business Problem

Modern applications must remain available even when containers, servers,
or management nodes fail. This project demonstrates how Docker Swarm
maintains application availability through self-healing, workload
rescheduling, and manager leader election using Infrastructure as Code
on AWS.

------------------------------------------------------------------------

# 🎯 Project Objectives

-   Provision AWS infrastructure with Terraform
-   Build a **3 Manager / 2 Worker** Docker Swarm cluster
-   Deploy a custom Docker image
-   Demonstrate:
    -   Container self-healing
    -   Worker node recovery
    -   Manager leader election
-   Explain quorum and Raft consensus
-   Document operational procedures like an SRE runbook

------------------------------------------------------------------------

# 🏗️ Solution Architecture

``` text
                    Internet
                        │
                 Docker Routing Mesh
                        │
      ┌─────────────────┴─────────────────┐
      │                                   │
 Manager1 (Leader)                  Manager2
              │
          Manager3
          /      \
     Worker1   Worker2

Service: novatech-web
Replicas: 3
```

------------------------------------------------------------------------

# 🛠️ Technology Stack

  Category         Technology
  ---------------- -------------------------------
  Cloud            AWS EC2, VPC, Security Groups
  IaC              Terraform
  Containers       Docker Engine, Docker Swarm
  OS               Ubuntu 22.04
  Automation       Bash
  Source Control   Git & GitHub

------------------------------------------------------------------------

# 📂 Repository Structure

``` text
engineering-for-failure-docker-swarm/
├── terraform/
├── scripts/
├── diagrams/
├── screenshots/
├── README.md
└── LICENSE
```

------------------------------------------------------------------------

# 🚀 Deployment Guide

### Phase 1 -- Provision Infrastructure

1.  Configure `terraform.tfvars`
2.  `terraform init`
3.  `terraform validate`
4.  `terraform plan`
5.  `terraform apply`

### Phase 2 -- Configure Docker Swarm

1.  Install Docker on all EC2 instances.
2.  Initialize Swarm on Manager1.
3.  Join Manager2 and Manager3.
4.  Join Worker1 and Worker2.
5.  Verify:
    -   `docker node ls`

### Phase 3 -- Deploy the Application

``` bash
docker service create \
  --name novatech-web \
  --replicas 3 \
  -p 80:80 \
  kevd637/novatech_ubuntu_server
```

Verify: - `docker service ls` - `docker service ps novatech-web`

------------------------------------------------------------------------

# 💥 Failure Scenarios

## 1️⃣ Container Failure

-   Kill a running container.
-   Swarm automatically launches a replacement.

## 2️⃣ Worker Node Failure

-   Shut down a worker.
-   Swarm reschedules workloads to healthy nodes.

## 3️⃣ Manager Failure

-   Shut down the leader.
-   Remaining managers maintain quorum.
-   Observe automatic leader election.

------------------------------------------------------------------------

# ✅ Validation Commands

``` bash
docker node ls
docker service ls
docker service ps novatech-web
docker ps
```

Capture screenshots before and after every failure.

------------------------------------------------------------------------

# 🎤 Interview Talking Points

-   Why are three managers preferred over two?
-   What is quorum?
-   How does Raft maintain consistency?
-   Difference between container and node failures.
-   Why Infrastructure as Code improves reliability.
-   How Docker Swarm differs from Kubernetes.

------------------------------------------------------------------------

# 🎓 Lessons Learned

-   High availability requires planning for failure.
-   Containers are disposable; services are resilient.
-   Automation reduces operational risk.
-   Distributed systems rely on consensus.

------------------------------------------------------------------------

# 📈 Future Enhancements

-   GitHub Actions deployment
-   CloudWatch observability
-   Prometheus & Grafana
-   Amazon EKS comparison
-   Blue/Green deployments

------------------------------------------------------------------------

# 👤 Author

**Kevin Harding**

Cloud Engineer \| DevOps \| AWS \| Infrastructure Automation
