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

module "instances" {
  source = "./instances"

  vpc_id      = module.network.vpc_id
  subnet1_id  = module.network.subnet1_id
  subnet2_id  = module.network.subnet2_id
  sg_app_id   = module.network.sg_app_id
  sg_mongo_id = module.network.sg_mongo_id

  log_bucket_name = "terraform-alb-logs-7yx4"

  tags = {
    environment = "dev"
    project     = "api-mongo-redis"
  }
}

module "ecr" {
  source = "./ecr"
}

module "ecs" {
  source = "./ecs"

  target_group_arn = module.instances.target_group_arn
  repo_url         = module.ecr.repository_url
}
