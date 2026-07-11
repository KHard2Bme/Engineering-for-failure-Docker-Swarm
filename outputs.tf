output "public_ips" {

  value = aws_instance.swarm[*].public_ip
}

output "private_ips" {

  value = aws_instance.swarm[*].private_ip
}

output "instance_names" {

  value = aws_instance.swarm[*].tags.Name
}