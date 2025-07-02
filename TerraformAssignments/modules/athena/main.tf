resource "aws_athena_database" "athena_database" {
  name   = var.database_name
  bucket = var.output_bucket_name
}

resource "aws_glue_catalog_table" "athena_table" {
  name          = var.table_name
  database_name = aws_athena_database.athena_database.name
  table_type    = "EXTERNAL_TABLE"

  storage_descriptor {
    columns {
      name = "id"
      type = "int"
    }
    columns {
      name = "name"
      type = "string"
    }

    location      = "s3://${var.table_data_location}"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
      parameters = {
        "field.delim" = ","
      }
    }

    compressed               = false
    stored_as_sub_directories = false
  }

  parameters = {
    "classification" = "csv"
  }
}

resource "aws_athena_workgroup" "athena_workgroup" {
  name = var.workgroup_name

  configuration {
    result_configuration {
      output_location = "s3://${var.output_bucket_name}/${var.result_prefix}"
    }

    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true
  }

  state = "ENABLED"
}

resource "aws_athena_named_query" "athena_sample_query" {
  name        = "sample_query"
  database    = aws_athena_database.athena_database.name
  query       = "SELECT * FROM ${aws_glue_catalog_table.athena_table.name} limit 10;"
  description = "Sample query to test Athena setup"
  workgroup   = aws_athena_workgroup.athena_workgroup.name
}

resource "aws_iam_role" "athena_execution_role" {
  name = "${var.name_prefix}-athena-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "athena.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "athena_iam_policy" {
  name = "${var.name_prefix}-athena-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject", "s3:PutObject"],
        Resource = "arn:aws:s3:::${var.output_bucket_name}/*"
      },
      {
        Effect   = "Allow",
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "athena_policy_attachment" {
  role       = aws_iam_role.athena_execution_role.name
  policy_arn = aws_iam_policy.athena_iam_policy.arn
}
