output "public_ips" {

  value = aws_instance.swarm[*].public_ip
}

output "private_ips" {

  value = aws_instance.swarm[*].private_ip
}

output "instance_names" {

  value = aws_instance.swarm[*].tags.Name
}

output "cloudwatch_dashboard" {

  value = aws_cloudwatch_dashboard.docker_swarm.dashboard_name

}