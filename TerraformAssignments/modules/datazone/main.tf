resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_iam_role" "datazone_domain_exec_role" {
  name = "${var.datazone_name}-domain-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "datazone.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

# Attach admin permissions temporarily
resource "aws_iam_role_policy_attachment" "datazone_exec_attach" {
  role       = aws_iam_role.datazone_domain_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_s3_bucket" "datazone_lake_bucket" {
  bucket        = "${var.bucket_prefix}-${random_id.suffix.hex}"
  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = var.tags
}

resource "aws_iam_role" "datazone_access_role" {
  name = "${var.datazone_name}-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "glue.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

data "aws_iam_policy_document" "datazone_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      aws_s3_bucket.datazone_lake_bucket.arn,
      "${aws_s3_bucket.datazone_lake_bucket.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "datazone_policy" {
  name   = "${var.datazone_name}-s3-access"
  policy = data.aws_iam_policy_document.datazone_policy.json
}

resource "aws_iam_role_policy_attachment" "datazone_policy_attachment" {
  role       = aws_iam_role.datazone_access_role.name
  policy_arn = aws_iam_policy.datazone_policy.arn
}

resource "aws_datazone_domain" "datazone_domain" {
  name                  = "${var.datazone_name}-domain"
  description           = "Domain for ${var.datazone_name}"
  domain_execution_role = aws_iam_role.datazone_domain_exec_role.arn
  tags                  = var.tags
}

resource "aws_datazone_project" "datazone_project" {
  name              = "${var.datazone_name}-project"
  domain_identifier = aws_datazone_domain.datazone_domain.id
  description       = "Project for ${var.datazone_name}"
}

resource "aws_datazone_environment_blueprint_configuration" "s3_blueprint_config" {
  domain_id                = aws_datazone_domain.datazone_domain.id
  environment_blueprint_id = "default-data-lake"
  enabled_regions          = ["us-east-1"]
  provisioning_role_arn    = aws_iam_role.datazone_access_role.arn
}
