#  AWS Athena Terraform Module Setup on S3

This Terraform-based setup provisions a complete Amazon Athena environment that allows you to run SQL queries
directly on data stored in Amazon S3 without the need to set up a database or server.
Modules Includes:
- An Athena **database** (`sampletestdb`)
- A Glue **catalog table** (`sampletest_table`) pointing to a CSV file in S3
- An Athena **workgroup** (`sampletest-wg`) with CloudWatch metrics enabled
- A **named query** to test data access
- IAM permissions to access S3, Glue, Athena, and CloudWatch
- All query results are stored in:  
  `s3://demo-athena-data-s3-bucket/athena-results/`

##  How to Deploy and Use

###  Upload Sample CSV File to S3

You can create a sample file:

```bash
echo -e "id,name\n1,Alice\n2,Bob\n3,Charlie" > sample.csv
aws s3 cp sample.csv s3://demo-athena-data-s3-bucket/athena/sample.csv**
```

###  Module Usage
module "athena" {
  source              = "./modules/athena"
  name_prefix         = "demo"
  database_name       = "sampletestdb"
  workgroup_name      = "sampletest-wg"
  output_bucket_name  = "demo-athena-data-s3-bucket"
  result_prefix       = "athena-results/"
  table_name          = "sampletest_table"
  table_data_location = "demo-athena-data-s3-bucket/athena/"
}
