# AWS Bedrock Terraform Module

This module provisions an AWS Lambda function with permissions to invoke Amazon Bedrock foundation models.

## Prerequisites

- AWS account with Bedrock enabled (e.g., `us-east-1`)
- IAM user with permissions:
  - `lambda:*`
  - `iam:PassRole`
  - `bedrock:InvokeModel`, `bedrock:InvokeModelWithResponseStream`
  - `logs:*`
- AWS CLI configured (`aws configure`)
- Terraform v1.3+ installed
- `zip` (Linux/macOS) or `Compress-Archive` (PowerShell)

## Usage

1. Zip the Lambda file:
 **Windows (PowerShell):**
   ```powershell
   Compress-Archive -Path .\lambda\bedrock_invoke.py -DestinationPath .\lambda\bedrock_invoke.zip
cd lambda

zip bedrock_invoke.zip bedrock_invoke.py

cd ..
2. Add bedrock.tf
```hcl
module "bedrock" {
  source = "./modules/bedrock"
  tags   = var.tags
}
```
