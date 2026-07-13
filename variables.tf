variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Existing AWS Key Pair"
  type        = string
}

variable "my_ip" {
  description = "Your Public IP Address"
  type        = string
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet" {
  default = "10.0.1.0/24"
}

variable "dashboard_name" {
  description = "CloudWatch Dashboard Name"
  type        = string
  default     = "DockerSwarm-HA-Dashboard"
}

