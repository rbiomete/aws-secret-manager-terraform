locals {
  filename = "SecretsManagerRDSMySQLRotationSingleUser.zip"
}

resource "aws_iam_role" "default" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.service.json
}

resource "aws_iam_role_policy_attachment" "lambda-vpc" {
  role       = aws_iam_role.default.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy" "SecretsManagerRDSMySQLRotationSingleUserRolePolicy0" {
  name   = "SecretsManagerRDSMySQLRotationSingleUserRolePolicy0"
  role   = aws_iam_role.default.name
  policy = data.aws_iam_policy_document.SecretsManagerRDSMySQLRotationSingleUserRolePolicy0.json
}

resource "aws_iam_role_policy" "SecretsManagerRDSMySQLRotationSingleUserRolePolicy1" {
  name   = "SecretsManagerRDSMySQLRotationSingleUserRolePolicy1"
  role   = aws_iam_role.default.name
  policy = data.aws_iam_policy_document.SecretsManagerRDSMySQLRotationSingleUserRolePolicy1.json
}

resource "aws_lambda_function" "default" {
  description      = "IOMETE SecMgr Password Rotation"
  filename         = "${path.module}/functions/${local.filename}"
  source_code_hash = filebase64sha256("${path.module}/functions/${local.filename}")
  function_name    = var.lambda_function_name
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  timeout          = 30
  role             = aws_iam_role.default.arn
  vpc_config {
    subnet_ids         = var.subnets_lambda
    security_group_ids = var.security_group
  }
  environment {
    variables = { #https://docs.aws.amazon.com/general/latest/gr/rande.html#asm_region
      SECRETS_MANAGER_ENDPOINT = "https://secretsmanager.${data.aws_region.current.name}.amazonaws.com"
    }
  }
}

resource "aws_lambda_permission" "default" {
  function_name = aws_lambda_function.default.function_name
  statement_id  = "AllowExecutionSecretManager"
  action        = "lambda:InvokeFunction"
  principal     = "secretsmanager.amazonaws.com"
}

resource "aws_kms_key" "default" {
  description         = "Key for Secrets Manager [iomete]"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.kms.json
}

resource "aws_kms_alias" "default" {
  name          = "alias/${var.kms_alias_name}"
  target_key_id = aws_kms_key.default.key_id
}


