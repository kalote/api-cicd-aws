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

module "instances" {
  source = "./instances"

  sg_app_id         = module.network.sg_app_id
  sg_mongo_id       = module.network.sg_mongo_id
  subnet_public_id  = module.network.subnet_public_id
  subnet_private_id = module.network.subnet_private_id
  ecr_repo_url      = module.ecr.repository_url
  version           = var.app_version
}
