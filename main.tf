provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 0.14.0"
}

# Deploy an EC2 Instance.
resource "aws_instance" "example" {
  ami                    = "ami-0b5eea76982371e91"
  instance_type          = "t2.micro"
  key_name               = "dck-1"
  vpc_security_group_ids = [aws_security_group.instance.id]
  }