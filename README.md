# Terraform-strapi
AWS EC2 and Terraform Setup
Objective

Learn AWS core concepts and launch an EC2 instance manually and using Terraform.

AWS Core Concepts

EC2
AMI
VPC
Subnets
Security Groups
EBS

Manual EC2 Setup

Created an AWS key pair
Launched an Amazon Linux 2 EC2 instance
Connected to the EC2 instance using SSH
Command Used to Connect EC2

ssh -i devops-key.pem ec2-user@<PUBLIC_IP>

AWS EC2 and Terraform Setup

Installed Terraform
Configured AWS provider
Created EC2 instance using Terraform
Generated and managed SSH key using Terraform
Applied infrastructure using Terraform

Terraform Workflow

Initialized Terraform
Validated configuration
Planned infrastructure
Applied configuration
Verified EC2 instance creation

Strapi Deployment on EC2

Installed Node.js and Yarn
Installed Strapi using quickstart method
Started Strapi server
Accessed Strapi using EC2 public IP
Access Application
Strapi application is accessible via:
http://<EC2_PUBLIC_IP>:1337

Cleanup

Destroyed infrastructure using Terraform
Verified all AWS resources were removed


Sadaf Ali Bin
DevOps & Cloud Enthusiast 🇮🇳
