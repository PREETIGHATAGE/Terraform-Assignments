#=============RedShift============================
/*
variable "name" {}
variable "node_type" {}
variable "cluster_type" {}
variable "number_of_nodes" {}
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
variable "publicly_accessible" { default = false }
variable "encrypted" { default = true }
variable "skip_final_snapshot" { default = true }

#=============DataZone============================
variable "datazone_name" {}
variable "bucket_prefix" {}

#==================Athena========================
variable "name_prefix" {
  type = string
}

variable "database_name" {
  type = string
}

variable "output_bucket_name" {
  type = string
}

variable "result_prefix" {
  type    = string
  default = "athena-results/"
}

variable "workgroup_name" {
  type = string
}

variable "table_name" {
  type = string
}

variable "table_data_location" {
  type = string
}

#=================BedRock==================

#=================Glue=====================
variable "glue_job_name" {}
variable "glue_role_name" {}
variable "glue_script_location" {}
variable "crawler_name" {}   
variable "database_name" {}
variable "s3_target_path" {}
variable "log_group_name" {}
variable "vpc_subnet_id" {}
variable "security_group_id" {}
variable "availability_zone" {
  type        = string
}
*/
variable "tags" {
  type = map(string)
}

#==============SageMaker============================
variable "subnet_id" {}
variable "security_group_ids" {
  type = list(string)
}

