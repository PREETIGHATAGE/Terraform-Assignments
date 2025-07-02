resource "aws_iam_role" "glue_role" {
  name = var.glue_role_name

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

resource "aws_iam_role_policy" "s3_access" {
  name = "glue-s3-access"
  role = aws_iam_role.glue_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"],
        Resource = [
          "arn:aws:s3:::demo-test-glue-s3-bucket",
          "arn:aws:s3:::demo-test-glue-s3-bucket/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "glue_policy_attach" {
  role       = aws_iam_role.glue_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_cloudwatch_log_group" "glue_logs" {
  name              = var.log_group_name
  retention_in_days = 7
}

resource "aws_glue_catalog_database" "glue_db" {
  name = var.database_name
}

resource "aws_glue_connection" "glue_conn" {
  name = "${var.glue_job_name}-conn"

  connection_type = "NETWORK"

  physical_connection_requirements {
    subnet_id              = var.vpc_subnet_id
    security_group_id_list = [var.security_group_id]
    availability_zone      = var.availability_zone 

  }
}

resource "aws_glue_crawler" "crawler" {
  name          = var.crawler_name
  role          = aws_iam_role.glue_role.arn
  database_name = aws_glue_catalog_database.glue_db.name

  s3_target {
    path = var.s3_target_path
  }

  configuration = jsonencode({
    Version = 1.0,
    CrawlerOutput = {
      Partitions = { AddOrUpdateBehavior = "InheritFromTable" }
    }
  })

  tags = var.tags
}

resource "aws_glue_job" "glue_job" {
  name     = var.glue_job_name
  role_arn = aws_iam_role.glue_role.arn

  command {
    name            = "glueetl"
    script_location = var.glue_script_location
    python_version  = "3"
  }

  execution_property {
    max_concurrent_runs = 1
  }

  default_arguments = {
    "--enable-metrics"                    = "true"
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-glue-datacatalog"          = "true"
    "--TempDir" = "s3://demo-test-glue-s3-bucket/temp"
  }

  connections  = [aws_glue_connection.glue_conn.name]
  glue_version = "4.0"
  max_retries  = 1
  tags         = var.tags
}

resource "aws_glue_trigger" "job_trigger" {
  name     = "${var.glue_job_name}-trigger"
  type     = "ON_DEMAND"

  actions {
    job_name = aws_glue_job.glue_job.name
  }

  tags = var.tags
}
