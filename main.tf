##############################################
# main.tf - Entry Point for ECS Infrastructure
# This file orchestrates key data sources used
# across the Terraform project.
##############################################

# Load all availability zones in the selected region
# Used to distribute subnets and ensure high availability
data "aws_availability_zones" "available" {}

module "budget" {
  count        = var.enable_budget ? 1 : 0
  source       = "./modules/budget"
  limit_amount = var.budget_limit_usd
  emails       = var.budget_emails
}

# (Optional) Add a local block if needed later
# locals {
#   project_name = "ecs-microservices"
# }

# (Optional) Terraform remote state configuration can go here
# if you're planning to use S3 + DynamoDB in production
# terraform {
#   backend "s3" {
#     bucket         = "your-state-bucket"
#     key            = "ecs/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }

# The rest of the infrastructure is defined in modular files:
# - vpc.tf            → Networking layer (VPC, subnets, routing)
# - cluster.tf        → ECS Cluster creation
# - task_definitions.tf → App containers definitions
# - service.tf        → ECS Services and scaling
# - roles.tf          → IAM roles for ECS/Fargate tasks
# - security.tf       → Security Groups and policies
# - outputs.tf        → Exports key resources for integration

# Keep this file light and descriptive.
# Your main.tf is the entry point to a production-grade IaC stack.
