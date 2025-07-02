# AWS SageMaker Terraform Module

This Terraform module provisions an **Amazon SageMaker Notebook Instance** within a specified VPC,
using a secure IAM role and customizable settings.

---

## Prerequisites

- Terraform v1.3.0 or newer
- AWS provider v5.0 or newer
- IAM user/role running Terraform must have permissions:
  - `sagemaker:CreateNotebookInstance`
  - `sagemaker:AddTags`
  - `iam:PassRole`
  - `ec2:DescribeSubnets`, `DescribeVpcs`, `DescribeSecurityGroups`
  - `logs:CreateLogGroup`, `logs:PutLogEvents` (optional for logs)

You must also have:
- A VPC with private subnet
- At least one security group
- Terraform configured with AWS credentials

---

## Module Usage

```hcl
module "sagemaker" {
  source             = "./modules/sagemaker"
  aws_region         = var.aws_region
  subnet_id          = var.subnet_id
  security_group_ids = var.security_group_ids
  tags               = var.tags
}
