output "bedrock_invoke_role_arn" {
  value = aws_iam_role.bedrock_invoke_role.arn
}

output "bedrock_policy_arn" {
  value = aws_iam_policy.bedrock_invoke_policy.arn
}
