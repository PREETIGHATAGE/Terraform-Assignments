resource "aws_iam_role" "bedrock_invoke_role" {
  name = "bedrock-invoke-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_policy" "bedrock_invoke_policy" {
  name        = "bedrock-invoke-policy"
  description = "Allow Bedrock model invocation"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "bedrock:InvokeModel",
          "bedrock:InvokeModelWithResponseStream"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.bedrock_invoke_role.name
  policy_arn = aws_iam_policy.bedrock_invoke_policy.arn
}

resource "aws_lambda_function" "bedrock_invoker" {
  function_name = "bedrock-invoke-function"
  role          = aws_iam_role.bedrock_invoke_role.arn
  runtime       = "python3.12"
  handler       = "bedrock_invoke.lambda_handler"
  filename      = "${path.module}/../../lambda/bedrock_invoke.zip"
  timeout       = 30

  environment {
    variables = {
      MODEL_ID = "anthropic.claude-v2"
    }
  }

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.bedrock_invoke_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
