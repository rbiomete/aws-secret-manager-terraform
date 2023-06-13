⛔️ [DEPRECATED]  : This is no longer supported.
 



This module will create  IAM roles/policies, lambda function, kms key and kms alias for secret manager.
 

# Usage Example
``` hcl
module "secmngr" {
  source         = "rbiomete/secret-manager/aws""
  security_group = data.aws_security_groups.selected.ids
  subnets_lambda = [data.aws_subnets.selected.ids[0]]
  lambda_function_name = var.lambda_function_name
  kms_alias_name = var.kms_alias_name
  microservice_role_name = var.microservice_role_name

}
```

