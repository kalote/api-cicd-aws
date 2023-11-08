terraform {
  required_version = ">= 1.0.0"
  backend "s3" {
    bucket         = "terraform-remote-state-7yx4"
    key            = "root/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-remote-state-dynamodb"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

module "state" {
  source = "./state"

  bucket_name = "terraform-remote-state-7yx4"
  table_name  = "terraform-remote-state-dynamodb"
}

module "network" {
  source = "./network"

  tags = {
    environment = "dev"
    project     = "api-mongo-redis"
  }
}

module "ecr" {
  source = "./ecr"
}
