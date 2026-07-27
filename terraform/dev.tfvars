aws_region      = "us-east-1"
environment     = "dev"
domain_name     = "yourcompanydomain.com" # Replace with your real Route53 domain name
vpc_cidr        = "10.1.0.0/16"
public_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnets = ["10.1.10.0/24", "10.1.11.0/24"]
db_subnets      = ["10.1.20.0/24", "10.1.21.0/24"]
db_password     = "DevPocSecurePass123!"
