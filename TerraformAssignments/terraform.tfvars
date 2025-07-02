#================REDSHIFT==================
/*
name                = "analytics"
node_type           = "ra3.xlplus"
cluster_type        = "multi-node"
number_of_nodes     = 2
subnet_ids          = ["subnet-0ab0f7020e3eda076", "subnet-089d17c599d8215ea"]
security_group_ids  = ["sg-0b79b78514c8cd64c"]
publicly_accessible = false
encrypted           = true
skip_final_snapshot = true

#================DataZone==================
datazone_name = "datazone"
bucket_prefix = "datazone-lake"

#===================Athena==================
name_prefix         = "demo"
database_name       = "sampledb"
workgroup_name      = "sample-wg"
result_prefix       = "athena-results/"
table_name          = "sample_table"
output_bucket_name  = "demo-athena-data-s3-bucket"
table_data_location = "demo-athena-data-s3-bucket/athena/"
*/
#===================BedRock=================
tags = {
  Environment = "dev"
  Owner       = "pree@gmail.com"

}
#================Glue========================
/*
glue_job_name       = "sampledemo-glue-job"
glue_role_name      = "glue-service-role"
glue_script_location = "s3://demo-test-glue-s3-bucket/scripts/sample-script.py"
crawler_name        = "sampledemo-crawler"
database_name       = "sampledemo_db"
s3_target_path      = "s3://demo-test-glue-s3-bucket/input-data/"
log_group_name      = "/aws-glue/jobs/logs"
vpc_subnet_id       = "subnet-089d17c599d8215ea"
security_group_id   = "sg-0b79b78514c8cd64c"
availability_zone = "us-east-1a" 
*/

#==================SageMaker==================

subnet_id          = "subnet-089d17c599d8215ea"
security_group_ids = ["sg-0b79b78514c8cd64c"]
