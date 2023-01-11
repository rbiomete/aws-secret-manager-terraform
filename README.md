This module will create all the resources to store and rotate a MySQL or Aurora password using the AWS Secrets Manager service.

# Prerequisites
* A VPC with private subnets and accessibilty to AWS Secrets Manager Endpoint, see below for more details.
* An RDS with MySQL or Aurora already created and reacheable from the private subnets


# Usage Example
``` hcl
module "secret-manager-with-rotation" {
  source                     = "giuseppeborgese/secret-manager-with-rotation/aws"
  version                    = "<always choose the latest version displayed in the upper right corner of this page>"
  name                       = "PassRotation" #name of function and other resources
  rotation_days              = 1
  subnets_lambda             = ["subnet-xxxxxx", "subnet-xxxxxx"]
  mysql_username             = "giuseppe"
  mysql_dbname               = "my_db_name"
  mysql_host                 =  "mysqlEndpointurl.xxxxxx.us-east-1.rds.amazonaws.com"
  mysql_password             = "dummy_password_will_we_rotated"
  mysql_dbInstanceIdentifier = "my_rds_db_identifier"
}
```

