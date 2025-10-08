variable "limit_amount" { type = number }
variable "emails"       { type = list(string) }

resource "aws_budgets_budget" "monthly" {
  name         = "monthly-budget"
  budget_type  = "COST"
  limit_unit   = "USD"
  limit_amount = var.limit_amount
  time_unit    = "MONTHLY"

  cost_types { include_credit = true }

  notification {
    comparison_operator           = "GREATER_THAN"
    threshold                     = 80
    threshold_type                = "PERCENTAGE"
    notification_type             = "FORECASTED"
    subscriber_email_addresses    = var.emails
  }
}
