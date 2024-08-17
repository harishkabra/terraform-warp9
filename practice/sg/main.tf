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
  security_groups = [ aws_security_group.webtraffic.name ]
  
}


resource "aws_security_group" "webtraffic" {
  name = "ALLOW HTTPS"

  ingress {
    from_port   = 443
    to_port     = 443
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