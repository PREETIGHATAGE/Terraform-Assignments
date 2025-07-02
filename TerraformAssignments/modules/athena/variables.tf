variable "name_prefix" {
  type        = string
  description = "Prefix for resource names"
}

variable "database_name" {
  type        = string
  description = "Name of the Athena database"
}

variable "output_bucket_name" {
  type        = string
  description = "S3 bucket to store Athena query results"
}

variable "result_prefix" {
  type        = string
  description = "Prefix for storing results in S3"
  default     = "athena-results/"
}

variable "workgroup_name" {
  type        = string
  description = "Name of the Athena workgroup"
}

variable "table_name" {
  type        = string
  description = "Name of the Glue table"
}

variable "table_data_location" {
  type        = string
  description = "S3 location where table data resides (without s3:// prefix)"
}
