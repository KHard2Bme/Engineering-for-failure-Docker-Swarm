output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_a_id" {
  description = "Public Subnet A ID"
  value       = aws_subnet.public_a.id
}

output "public_subnet_b_id" {
  description = "Public Subnet B ID"
  value       = aws_subnet.public_b.id
}

output "security_group_id" {
  description = "Docker Swarm Security Group ID"
  value       = aws_security_group.docker_swarm.id
}

output "instance_ids" {
  description = "EC2 Instance IDs"
  value = {
    for name, instance in aws_instance.nodes :
    name => instance.id
  }
}

output "public_ips" {
  description = "Public IP addresses"
  value = {
    for name, instance in aws_instance.nodes :
    name => instance.public_ip
  }
}

output "public_dns" {
  description = "Public DNS names"
  value = {
    for name, instance in aws_instance.nodes :
    name => instance.public_dns
  }
}

output "cloudwatch_dashboard_name" {
  description = "CloudWatch Dashboard"
  value       = aws_cloudwatch_dashboard.dashboard.dashboard_name
}