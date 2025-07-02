output "redshift_cluster_endpoint" {
  value = aws_redshift_cluster.redshift_cluster.endpoint
}

output "redshift_cluster_id" {
  value = aws_redshift_cluster.redshift_cluster.id
}

output "redshift_secret_arn" {
  value = aws_secretsmanager_secret.redshift_secret.arn
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.redshift_logs.name
}
