

variable vpc_cidr_bloc {}
variable subnet_cidr_block {}
variable avail_zone {}
variable env_prefix {}
variable myip_address {}
variable public_key_location {}


# Define the VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "LS-Exam-vpc"
  }
}

# Define the subnet
resource "aws_subnet" "production_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "LS-Exam-subnet"
  }
}

# Define the ECS Cluster
resource "aws_ecs_cluster" "my_ecs_cluster" {
  name = "LS-Exam-Cluster"
  tags = {
    Name = "LS-Exam-Cluster"
  }
  # Attach to the VPC
  network_configuration {
    security_groups = []
    subnets = [aws_subnet.my_subnet.id]
  }
}
