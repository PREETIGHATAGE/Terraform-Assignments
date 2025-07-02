variable "datazone_name" {
  description = "Prefix name for DataZone resources"
  type        = string
}

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
