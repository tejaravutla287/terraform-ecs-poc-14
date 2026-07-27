# Find this resource block inside your existing ecs.tf file and update container_definitions:
  container_definitions = jsonencode([{
    name      = "website"
    image     = "nginxdemos/hello:latest" # Switch to your ECR image path when pushed
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
    environment = [
      { name = "DB_HOST", value = aws_rds_cluster.aurora.endpoint },
      { name = "DB_NAME", value = var.db_name },
      { name = "DB_USER", value = var.db_username },
      { name = "DB_PASSWORD", value = var.db_password },
      { name = "NODE_ENV", value = var.environment }
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.ecs.name
        "awslogs-region"        = var.aws_region
        "awslogs-stream-prefix" = "web"
      }
    }
  }])
