variable "project_name" {
  default = "terraform-ecs-microservice"
}

variable "region" {
  default = "us-east-1"
}

variable "account_id" {
  description = "AWS Account ID for ECR"
  type        = string
}

variable "enable_natgw" {
  type    = bool
  default = false
}

variable "enable_alb" {
  type    = bool
  default = false
}

variable "enable_ecs" {  # controla service/task
  type    = bool
  default = false
}

variable "enable_budget" {
  type    = bool
  default = true
}

variable "budget_limit_usd" {
  type        = number
  default     = 5
  description = "Alert budget monthly (USD)"
}

variable "budget_emails" {
  type        = list(string)
  default     = ["hspedroso@gmail.com"]
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS tasks"
  type        = list(string)
  default     = []
}