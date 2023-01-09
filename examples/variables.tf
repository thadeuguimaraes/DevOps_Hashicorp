//INPUTS

data "aws_availability_zones" "available" {}

variable "aws_region" { default = "us-east-1" }

variable "vpc_cidr" {
  default     = "172.17.0.0/16"
  description = "VPC IP range in CIDR notation (including mask)"
}

variable "region" {
  description = "Allows user to control region to work in. Defaults to the one configured in current provider"
  default     = "us-east-1"
}

variable "azs" {
  description = "Allows user to control availability zones to work in. Defaults to all possible zones available in the current region"
  type        = map(any)
  default     = {}
}

variable "newbits" {
  description = "Makes an IP address range in CIDR notation (like 10.0.0.0/8) and extends its prefix to include an additional subnet number. For example, cidrsubnet('10.0.0.0/8', 8, 2) returns 10.2.0.0/16."
  default     = "2"
}

variable "default_tag" {
  type    = string
  default = "devops-hashicorp"
}

locals {
  availability_zones = lookup(var.azs, var.region, join(",", data.aws_availability_zones.available.names))
}