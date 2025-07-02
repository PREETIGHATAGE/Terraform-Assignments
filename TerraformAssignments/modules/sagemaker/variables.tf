variable "subnet_id" {}
variable "security_group_ids" {
  type = list(string)
}
variable "tags" {
    type = map(string)
}

variable "instance_type" {
  default = "ml.t2.medium"
}
