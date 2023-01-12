
variable "subnets_lambda" {
  type        = list(any)
  description = "The subnets where the Lambda Function will be run"
}


variable "secretsmanager_masterarn" {
  type        = string
  description = "The ARN of the Secrets Manager which rotates the MySQL superuser"
  default     = ""
}

variable "additional_kms_role_arn" {
 type        = list
 description = "If you want add another role of another resource to access to the kms key used to encrypt the secret"
 default     = []
}

variable "security_group" {
  type        = list(any)
  description = "The security group(s) where the Lambda Function will be run. This must have access to the RDS instance. The best option is to make this the RDS' security group and allow the SG to access itself"
}

 
variable "lambda_function_name" {
  description = "Name of the Lambda Function"
  type        = string
}


variable "kms_alias_name" {
  description = "KMS alias name"
  type        = string
 }

 variable "iam_role_name" {
  description = "IAM role name"
  type        = string
  default = "iomete-password_rotation"
 }
   
