variable "name" {
  description = "Prefix for resources"
  type        = string
}

variable "node_type" {
  description = "Redshift node type (e.g., dc2.large)"
  type        = string
}

variable "cluster_type" {
  description = "Cluster type (single-node or multi-node)"
  type        = string
}

variable "number_of_nodes" {
  description = "Number of nodes (for multi-node only)"
  type        = number
  default     = 2
}

variable "subnet_ids" {
  description = "List of subnet IDs for Redshift subnet group"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "If true, Redshift is accessible publicly"
  type        = bool
  default     = false
}

variable "encrypted" {
  description = "Whether Redshift is encrypted"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "If true, skips snapshot on deletion"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}
