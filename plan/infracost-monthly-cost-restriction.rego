package spacelift

# This example plan policy demonstrates using data from infracost to
# ensure that resources can't be created if their mostly cost is greater than 
# a specific threshold while displaying a warning if their cost is above
# a different threshold.
#
# You can read more about plan policies here:
# https://docs.spacelift.io/concepts/policy/terraform-plan-policy

# Prevent any changes that will cause the monthly cost to go above a certain threshold
deny[sprintf("monthly cost greater than $%d ($%.2f)", [threshold, monthly_cost])] {
  threshold := 100
  monthly_cost := to_number(input.third_party_metadata.infracost.projects[0].breakdown.totalMonthlyCost)
  monthly_cost > threshold
}

# Warn if the monthly costs increase more than a certain percentage
warn[sprintf("monthly cost increase greater than %d%% (%.2f%%)", [threshold, percentage_increase])] {
  threshold := 5
  previous_cost := to_number(input.third_party_metadata.infracost.projects[0].pastBreakdown.totalMonthlyCost)
  previous_cost > 0

  monthly_cost := to_number(input.third_party_metadata.infracost.projects[0].breakdown.totalMonthlyCost)
  percentage_increase := ((monthly_cost - previous_cost) / previous_cost) * 100

  percentage_increase > threshold
}

# Learn more about sampling policy evaluations here:
# https://docs.spacelift.io/concepts/policy#sampling-policy-inputs
sample { true }
