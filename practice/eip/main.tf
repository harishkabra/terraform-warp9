terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  profile = "cl-dev"
}

#ami-0ae8f15ae66fe8cda

resource "aws_instance" "ec2" {
  ami = "ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"
  
}

resource "aws_eip" "elasticeip" {
  instance = aws_instance.ec2.id
  domain   = "vpc"
}

output "EIP" {
  value = aws_eip.elasticeip.public_ip
}