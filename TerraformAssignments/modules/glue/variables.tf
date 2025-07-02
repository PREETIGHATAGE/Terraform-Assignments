variable "glue_job_name" {}
variable "glue_role_name" {}
variable "glue_script_location" {}
variable "crawler_name" {
      type        = string
}
variable "database_name" {}
variable "s3_target_path" {}
variable "log_group_name" {}
variable "vpc_subnet_id" {}
variable "security_group_id" {}
variable "tags" {
  type = map(string)
}
variable "availability_zone" {
  description = "Availability zone of the subnet"
  type        = string
}

