

output "kms_key" {
  description = "The KEY_ID of the KMS"
  value       = try(aws_kms_key.default.key_id, "")
}


output "aws_lambda_function" {
description = "aws lambda function"
  value = aws_lambda_function.default.arn
}
