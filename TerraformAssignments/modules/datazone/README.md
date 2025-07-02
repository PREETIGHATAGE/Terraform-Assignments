# AWS DataZone Terraform Module

This Terraform module provisions AWS DataZone components, including:
- S3 lake bucket
- IAM roles and policies for DataZone and Glue access
- DataZone domain
- DataZone project
- Environment blueprint configuration

## Prerequisites

Ensure the following before using this module:

- Terraform v1.5 or above
- Permissions for the following actions:
  - `datazone:CreateDomain`, `datazone:PutEnvironmentBlueprintConfiguration`, `datazone:CreateProject`
  - `iam:*` (for role/policy creation)
  - `s3:*` (for lake bucket)
- DataZone must be enabled in your AWS account
- Use the correct `environment_blueprint_id` that exists in your domain

## Module Usage

```hcl
module "datazone" {
  source = "../modules/datazone"

  datazone_name           = "analytics"
  bucket_prefix           = "analytics-lake"
  environment_blueprint_id = "default-data-lake"
  tags = {
    Environment = "dev"
    Project     = "datazone"
  }
}
