resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_iam_role" "sagemaker_execution_role" {
  name = "sagemaker-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "sagemaker.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.sagemaker_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

resource "aws_sagemaker_notebook_instance" "notebook" {
  name                 = "sagemaker-notebook-${random_id.suffix.hex}"
  instance_type        = var.instance_type
  role_arn             = aws_iam_role.sagemaker_execution_role.arn
  subnet_id            = var.subnet_id
  security_groups      = var.security_group_ids
  tags = var.tags
}
