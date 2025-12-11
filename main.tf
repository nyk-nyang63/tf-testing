terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

# Reuse the existing VPC
data "aws_vpc" "selected" {
  id = "vpc-0e6e8e8aef7ccf35f"
}

# Create a simple security group inside the VPC
resource "aws_security_group" "jenkins_test_sg" {
  name        = "jenkins-test-sg"
  description = "SG created by Jenkins Terraform test"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description = "Allow ping"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "jenkins-test-sg"
    CreatedBy   = "Jenkins"
    Purpose     = "Terraform pipeline verification"
  }
}

output "security_group_id" {
  value = aws_security_group.jenkins_test_sg.id
}

