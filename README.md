# POC-18: Multi-Environment AWS ECS Fargate & Aurora Serverless Integration

This proof of concept provides isolated `dev` and `staging` hosting environments managed entirely via infrastructure as code.

## 🛠 Prerequisites
- Docker Installed
- Terraform (`>= 1.0.0`)
- Valid AWS Credentials configured via AWS CLI (`aws configure`)
- A public registered domain hosted within Route53

## 💻 Local Testing Workflows
To test the web configuration container engine structure natively on your workspace without spinning up AWS resources:
```bash
make run-local
```
Then navigate to `http://localhost:8080`.

## 🚀 AWS Cloud Infrastructure Deployment

### 1. Initialize Project Core
```bash
make init
```

### 2. Launch Development Environment Tier
```bash
make plan ENV=dev
make apply ENV=dev
```

### 3. Launch Staging Environment Tier
```bash
make plan ENV=staging
make apply ENV=staging
```

### 4. Tear Down Environments (Crucial for Cost Savings)
When done executing your POC validation routines, remove resource structures to avoid lingering cloud charges:
```bash
make destroy ENV=dev
make destroy ENV=staging
```
