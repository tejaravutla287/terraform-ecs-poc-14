# Cost Savings: Uses Aurora Serverless v2 configuration with tight min/max scaling
resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "${var.environment}-aurora-cluster"
  engine                  = "aurora-postgresql"
  engine_version          = "15.4"
  database_name           = var.db_name
  master_username         = var.db_username
  master_password         = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.aurora.name
  vpc_security_group_ids  = [aws_security_group.db.id]
  skip_final_snapshot     = true
  
  serverless_v2_scaling_configuration {
    min_capacity = 0.5
    max_capacity = 1.0
  }
}

# Configures high-availability by spawning multi-AZ compute attachments
resource "aws_rds_cluster_instance" "aurora_instances" {
  count              = 2
  identifier         = "${var.environment}-aurora-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.aurora.engine
  engine_version     = aws_rds_cluster.aurora.engine_version
}
