/*output "redshift_cluster_endpoint" {
  value = module.redshift.redshift_cluster_endpoint
}

output "datazone_bucket_name" {
  value = module.datazone.datazone_bucket_name
}

output "datazone_domain_id" {
  value = module.datazone.datazone_domain_id
}

output "datazone_project_id" {
  value = module.datazone.datazone_project_id
}

output "datazone_access_role_arn" {
  value = module.datazone.datazone_access_role_arn
}

output "datazone_exec_role_arn" {
  value = module.datazone.datazone_exec_role_arn
}

#===================ATHENA======================
output "athena_workgroup" {
  value = module.athena.athena_workgroup
}

output "athena_database" {
  value = module.athena.athena_database_name
}

output "glue_table" {
  value = module.athena.athena_table_name
}

output "named_query_sql" {
  value = module.athena.athena_named_query
}

#==================BedRock==========================
output "bedrock_role_arn" {
  value = module.bedrock.bedrock_invoke_role_arn
}

output "bedrock_policy_arn" {
  value = module.bedrock.bedrock_policy_arn
}
*/
#================Glue==============================
/*output "glue_job_name" {
  value = module.glue.glue_job_name
}*/

#================SageMaker========================
output "sagemaker_notebook_name" {
  value = module.sagemaker.notebook_name
}

output "sagemaker_execution_role_arn" {
  value = module.sagemaker.execution_role_arn
}
