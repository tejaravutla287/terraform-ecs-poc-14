aws_region      = "us-east-1"
environment     = "staging"
domain_name     = "yourcompanydomain.com" # Replace with your real Route53 domain name
vpc_cidr        = "10.2.0.0/16"
public_subnets  = ["10.2.1.0/24", "10.2.2.0/24"]
private_subnets = ["10.2.10.0/24", "10.2.11.0/24"]
db_subnets      = ["10.2.20.0/24", "10.2.21.0/24"]
db_password     = "StagingPocSecurePass456!"
