package spacelift

# Test case for denying when monthly estimated cost exceeds a certain threshold.
test_deny_infracost_monthly_cost_exceeds_threshold {
	deny["monthly cost greater than $100 ($101.00)"] with input as {"third_party_metadata": {"infracost": {"projects": [{"breakdown": {"totalMonthlyCost": 101.00}}]}}}
}

# Test case for not denying when monthly estimated cost is below a certain threshold.
test_not_deny_infracost_monthly_cost_is_below_threshold {
	count(deny) == 0 with input as {"third_party_metadata": {"infracost": {"projects": [{"breakdown": {"totalMonthlyCost": 99.00}}]}}}
}

# Test case for warning when monthly costs increased more than a certain percentage.
test_warn_infracost_monthly_cost_increase_percentage_exceeds_threshold {
	warn["monthly cost increase greater than 5% (395.05%)"] with input as {"third_party_metadata": {"infracost": {"projects": [{"breakdown": {"totalMonthlyCost": 5.00}, "pastBreakdown": {"totalMonthlyCost": 1.01}}]}}}
}

# Test case for not warning when monthly costs increased less than a certain percentage.
test_not_warn_infracost_monthly_cost_increase_percentage_does_not_exceed_threshold {
	count(warn) == 0 with input as {"third_party_metadata": {"infracost": {"projects": [{"breakdown": {"totalMonthlyCost": 40.10}, "pastBreakdown": {"totalMonthlyCost": 40.00}}]}}}
}
