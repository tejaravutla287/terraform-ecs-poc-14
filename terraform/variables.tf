variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "environment" {
  type        = string
  description = "dev or staging"
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "db_subnets" {
  type = list(string)
}

variable "domain_name" {
  type        = string
  description = "The top-level domain registered in Route53 (e.g., example.com)"
}

variable "db_name" {
  type    = string
  default = "pocdb"
}

variable "db_username" {
  type    = string
  default = "pocadmin"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Database master password"
}
