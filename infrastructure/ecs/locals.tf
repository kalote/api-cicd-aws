locals {
  env_secrets = jsondecode(data.aws_secretsmanager_secret_version.env.secret_string)

  env_secrets_list = [
    for name, value in local.env_secrets : {
      name  = name
      value = value
    }
  ]
}
