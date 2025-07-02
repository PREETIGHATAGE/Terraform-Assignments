# AWS Redshift Terraform Module

This module provisions a secure Redshift cluster along with:
- Subnet group
- IAM-based Secrets Manager integration
- CloudWatch log group

##  Prerequisites

Before deploying this module:

- AWS credentials with Redshift, IAM, SecretsManager, CloudWatch, SNS access
- Terraform v1.5 or newer
- Ensure subnet IDs and security group IDs are passed correctly
- Ensure the cluster identifier does not already exist

## 🚀 Usage

```hcl
module "redshift" {
  source             = "../modules/redshift"
  name               = "analytics"
  node_type          = "ra3.xlplus"
  cluster_type       = "multi-node"
  number_of_nodes    = 2
  subnet_ids         = ["subnet-abc", "subnet-def"]
  security_group_ids = ["sg-123"]
  publicly_accessible = false
  encrypted          = true
  skip_final_snapshot = true
  sns_topic_arn      = "arn:aws:sns:us-east-1:xxxx:redshift-events"
  tags = {
    Environment = "dev"
  }
}
