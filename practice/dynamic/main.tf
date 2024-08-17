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

variable "ingressrules" {
  type = list(number)
  default = [ 80,443 ]
}

variable "iegressrules" {
  type = list(number)
  default = [ 80,443,25,3306,53,8080]
}

#ami-0ae8f15ae66fe8cda

resource "aws_instance" "ec2" {
  ami = "ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"
  security_groups = [ aws_security_group.webtraffic.name ]
  
}


resource "aws_security_group" "webtraffic" {
  name = "ALLOW HTTPS"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.iegressrules
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}