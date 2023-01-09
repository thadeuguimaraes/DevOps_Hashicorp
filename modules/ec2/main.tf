rovider "aws" {
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

  # When the instance boots, start a web server on port 8080 that responds with "Hello, World!".
  user_data = <<EOF
 #!/bin/bash
 echo "Hello, World!" > index.html
 nohup busybox httpd -f -p 8080 &
 EOF
 }

# Allow the instance to receive requests on port 8080.
resource "aws_security_group" "instance" {
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
