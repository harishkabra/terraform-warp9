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

