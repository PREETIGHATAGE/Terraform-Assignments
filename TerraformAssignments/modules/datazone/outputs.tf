output "datazone_bucket_name" {
  description = "S3 bucket name used as lake"
  value       = aws_s3_bucket.datazone_lake_bucket.bucket
}

output "datazone_domain_id" {
  description = "ID of the created DataZone domain"
  value       = aws_datazone_domain.datazone_domain.id
}

output "datazone_project_id" {
  description = "ID of the DataZone project"
  value       = aws_datazone_project.datazone_project.id
}

output "datazone_access_role_arn" {
  description = "IAM Role ARN for DataZone S3 access"
  value       = aws_iam_role.datazone_access_role.arn
}

output "datazone_exec_role_arn" {
  description = "IAM Execution Role ARN for the DataZone domain"
  value       = aws_iam_role.datazone_domain_exec_role.arn
}
