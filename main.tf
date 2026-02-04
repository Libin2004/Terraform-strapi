terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source = "hashicorp/tls"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# -----------------------------
# Create Key Pair (.pem)
# -----------------------------
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = "strapi-key"
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_file" "pem" {
  filename        = "strapi-key.pem"
  content         = tls_private_key.this.private_key_pem
  file_permission = "0400"
}

# -----------------------------
# Security Group
# -----------------------------
resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg"
  description = "Allow SSH and Strapi"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# -----------------------------
# EC2 Instance
# -----------------------------
resource "aws_instance" "strapi_ec2" {
  ami                    = "ami-0a0e5d9c7acc336f1" # Ubuntu 22.04 us-east-1
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.this.key_name
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  tags = {
    Name = "Strapi-EC2"
  }
}

# -----------------------------
# Outputs
# -----------------------------
output "ec2_public_ip" {
  value = aws_instance.strapi_ec2.public_ip
}

output "ssh_command" {
  value = "ssh -i strapi-key.pem ubuntu@${aws_instance.strapi_ec2.public_ip}"
}
