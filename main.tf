#################################################
# Ubuntu AMI
#################################################

data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    ]
  }
}

#################################################
# Networking
#################################################

resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "public" {

  vpc_id = aws_vpc.main.id

  cidr_block = var.public_subnet

  map_public_ip_on_launch = true
}

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {

  subnet_id = aws_subnet.public.id

  route_table_id = aws_route_table.public.id
}

#################################################
# Security Group
#################################################

resource "aws_security_group" "docker" {

  name = "docker-swarm"

  vpc_id = aws_vpc.main.id

  ingress {

    from_port = 22

    to_port = 22

    protocol = "tcp"

    cidr_blocks = [var.my_ip]
  }

  ingress {

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    from_port = 2377

    to_port = 2377

    protocol = "tcp"

    self = true
  }

  ingress {

    from_port = 7946

    to_port = 7946

    protocol = "tcp"

    self = true
  }

  ingress {

    from_port = 7946

    to_port = 7946

    protocol = "udp"

    self = true
  }

  ingress {

    from_port = 4789

    to_port = 4789

    protocol = "udp"

    self = true
  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }
}

#################################################
# EC2 Instances
#################################################

resource "aws_instance" "swarm" {

  count = 5

  ami = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  subnet_id = aws_subnet.public.id

  key_name = var.key_name

  vpc_security_group_ids = [

    aws_security_group.docker.id

  ]

  user_data = file("${path.module}/docker_install.sh")

  tags = {

    Name = element(

      [

        "Manager1",

        "Manager2",

        "Manager3",

        "Worker1",

        "Worker2"

      ],

      count.index

    )
  }
}

#################################################
# CloudWatch Dashboard
#################################################

resource "aws_cloudwatch_dashboard" "docker_swarm" {

  dashboard_name = var.dashboard_name

  dashboard_body = jsonencode({

    widgets = [

      #################################################
      # CPU Utilization
      #################################################

      {

        type = "metric"

        x = 0

        y = 0

        width = 12

        height = 6

        properties = {

          title = "EC2 CPU Utilization"

          view = "timeSeries"

          stacked = false

          region = var.aws_region

          metrics = [

            for instance in aws_instance.swarm :

            [

              "AWS/EC2",

              "CPUUtilization",

              "InstanceId",

              instance.id

            ]

          ]

        }

      },

      #################################################
      # Status Checks
      #################################################

      {

        type = "metric"

        x = 12

        y = 0

        width = 12

        height = 6

        properties = {

          title = "EC2 Status Checks"

          region = var.aws_region

          view = "timeSeries"

          metrics = [

            for instance in aws_instance.swarm :

            [

              "AWS/EC2",

              "StatusCheckFailed",

              "InstanceId",

              instance.id

            ]

          ]

        }

      },

      #################################################
      # Network In
      #################################################

      {

        type = "metric"

        x = 0

        y = 6

        width = 12

        height = 6

        properties = {

          title = "Network In"

          region = var.aws_region

          metrics = [

            for instance in aws_instance.swarm :

            [

              "AWS/EC2",

              "NetworkIn",

              "InstanceId",

              instance.id

            ]

          ]

        }

      },

      #################################################
      # Network Out
      #################################################

      {

        type = "metric"

        x = 12

        y = 6

        width = 12

        height = 6

        properties = {

          title = "Network Out"

          region = var.aws_region

          metrics = [

            for instance in aws_instance.swarm :

            [

              "AWS/EC2",

              "NetworkOut",

              "InstanceId",

              instance.id

            ]

          ]

        }

      }

    ]

  })

}