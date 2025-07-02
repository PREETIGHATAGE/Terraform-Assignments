resource "random_password" "password" {
  length           = 16
  lower            = true
  upper            = true
  numeric          = true
  special          = true
  override_special = "!#$%^&*()_-+="
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_secretsmanager_secret" "redshift_secret" {
  name = "redshift-${var.name}-credentials-${random_id.suffix.hex}"
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "redshift_secret_version" {
  secret_id     = aws_secretsmanager_secret.redshift_secret.id
  secret_string = jsonencode({
    username = "redshift_admin_user"
    password = random_password.password.result
  })
}

locals {
  secret_creds = jsondecode(aws_secretsmanager_secret_version.redshift_secret_version.secret_string)
}

resource "aws_redshift_subnet_group" "redshift_subnet" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_redshift_cluster" "redshift_cluster" {
  cluster_identifier          = "${var.name}-redshift-cluster"
  node_type                   = var.node_type
  master_username             = local.secret_creds.username
  master_password             = local.secret_creds.password
  cluster_type                = var.cluster_type
  number_of_nodes             = var.number_of_nodes
  vpc_security_group_ids      = var.security_group_ids
  cluster_subnet_group_name   = aws_redshift_subnet_group.redshift_subnet.name
  publicly_accessible         = var.publicly_accessible
  encrypted                   = var.encrypted
  skip_final_snapshot         = var.skip_final_snapshot
  final_snapshot_identifier   = "${var.name}-redshift-cluster-final-snapshot"
  tags                        = var.tags
}

resource "aws_cloudwatch_log_group" "redshift_logs" {
  name              = "/aws/redshift/${var.name}-redshift-cluster"
  retention_in_days = 30
  tags              = var.tags
}

resource "aws_sns_topic" "redshift_events" {
  name = "${var.name}-redshift-events"
  tags = var.tags
}

resource "aws_redshift_event_subscription" "events" {
  name             = "${var.name}-redshift-cluster-events"
  sns_topic_arn    = aws_sns_topic.redshift_events.arn
  source_type      = "cluster"
  source_ids       = [aws_redshift_cluster.redshift_cluster.id]
  event_categories = ["configuration", "management", "monitoring"]
  severity         = "INFO"
  enabled          = true
}
