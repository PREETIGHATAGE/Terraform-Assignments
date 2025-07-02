output "athena_database_name" {
  value = aws_athena_database.athena_database.name
}

output "athena_table_name" {
  value = aws_glue_catalog_table.athena_table.name
}

output "athena_named_query" {
  value = aws_athena_named_query.athena_sample_query.query
}

output "athena_workgroup" {
  value = aws_athena_workgroup.athena_workgroup.name
}

output "athena_iam_role_arn" {
  value = aws_iam_role.athena_execution_role.arn
}
