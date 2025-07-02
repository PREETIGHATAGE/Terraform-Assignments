# AWS Glue Terraform Module

This Terraform module provisions AWS Glue resources including:
- Glue Job
- Glue Crawler
- Glue Catalog Database
- Glue Trigger
- Glue Connection (for VPC access)
- IAM Role
- CloudWatch Log Group

---

## Prerequisites

- AWS CLI configured
- Terraform v1.3+ installed
- IAM user or role with permissions:
  - `glue:*`
  - `s3:*`
  - `logs:*`
  - `iam:PassRole`
- An existing S3 bucket for:
  - ETL scripts (e.g. `scripts/sample-script.py`)
  - Input data (e.g. `input-data/`)
  - Output data (e.g. `output-data/`)
  - Temporary files (e.g. `temp/`)

---

## Module Usage

```hcl
module "glue" {
  source = "./modules/glue"

  glue_job_name         = var.glue_job_name
  glue_role_name        = var.glue_role_name
  glue_script_location  = var.glue_script_location
  crawler_name          = var.crawler_name
  database_name         = var.database_name
  s3_target_path        = var.s3_target_path
  log_group_name        = var.log_group_name
  vpc_subnet_id         = var.vpc_subnet_id
  security_group_id     = var.security_group_id
  availability_zone     = var.availability_zone
  tags                  = var.tags
}
