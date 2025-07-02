module "athena" {
  source              = "./modules/athena"
  name_prefix         = "demo-test"
  database_name       = "sampletestdb"
  workgroup_name      = "sampletest-wg"
  output_bucket_name  = "demo-athena-data-s3-bucket"
  result_prefix       = "athena-results/"
  table_name          = "sampletest_table"
  table_data_location = "demo-athena-data-s3-bucket/athena/"
}
